require 'puppet/util/cli_execution'
require 'puppet/util/cli_parser'
require 'puppet/util/path_generator'

Puppet::Type.type(:jboss_batch).provide(:cli) do
  include Puppet::Util::CliExecution
  extend  Puppet::Util::CliExecution
  
  def self.prefetch(resources)
    cached_results = {}
    parser = CliParser.new

    resources.each { |name, resource|
      # don't try to prefetch if noop
      unless resource[:noop]

        # set up attributes of the 'is' provider resource
        is_resource_attributes = {:name => name, :batch => []}

        # dump the root resrouce and cache it
        if cached_results[resource[:server]].nil?
          cached_results[resource[:server]] = execute_cli get_server(resource), format_command('/', 'read-resource', {:recursive => true}), false
        end

        # determine the current state of each batch element and add it to the current 'is' provider resource attributes
        resource[:batch].each { |batch_element|
          # if batch elment is a resource
          # else if batch element is a command
          # else error
          if batch_element.has_key?('address')
            # get the current value of for the given address
            path     = parser.parse_path(batch_element['address'])
            is_value = PathGenerator.root_dump_position(path, cached_results[resource[:server]]['result'])

            # create hash of current resource status
            is_batch_element = { 'address' => batch_element['address'] }
            if is_value
              is_batch_element['ensure']  = "present"
              is_batch_element['options'] = is_value
            else
              is_batch_element['ensure']  = "absent"
            end
  
            is_resource_attributes[:batch].push(is_batch_element)
          elsif batch_element.has_key?('command')
            # the current state of a command is that it has not been run 
            is_resource_attributes[:batch].push({ 'command' => batch_element['command'], 'ensure' => :absent})
          else
            # this error condition should have already been caught by now but throw it here just in case
            raise "Element of the batch is not recognized as a command or a resource, must specify either 'address' or 'command' respectivly: #{batch_element.inspect}"
          end
        }

        # set the 'is' provider for the given resource
        Puppet.debug "jboss_batch[name=#{name}: is_resource_attributes: #{is_resource_attributes.inspect}"
        resource.provider = new(is_resource_attributes)
      end
    }
  end

  def initialize(value={})
    super(value)
    @new_values = {}
  end

  def batch
    @property_hash[:batch]
  end

  def batch=(value)
    @new_values[:batch] = value
  end

  def flush
    tries = self.resource[:tries]
    try_sleep = self.resource[:try_sleep]

    output = nil
    last_error = nil

    # attempt CLI batch for each try
    tries.times do |try|
      begin
        # Only add debug messages for tries > 1 to reduce log spam.
        debug("Exec try #{try+1}/#{tries}") if tries > 1

        # run the batch 
        output = execute_batch(@property_hash[:batch], @new_values[:batch])

        # break the try loop if batch was a success
        break if (resource[:expected_output].to_a - output.to_a).empty?

        # sleep before next attempt
        if try_sleep > 0 and tries > 1
          debug("Sleeping for #{try_sleep} seconds between tries")
          sleep try_sleep
        end
      rescue => e
        last_error = e
      end
    end

    if (!output)
      self.fail("Error executing CLI batch `#{resource[:title]}`: #{last_error}")
    end

    # determine if the execution was a success
    success = (resource[:expected_output].to_a - output.to_a).empty?

    # log output if required
    if (resource[:logoutput] == :true || (!success && resource[:logoutput] == :on_failure))
      self.send(@resource[:loglevel], output.inspect)
    end

    # fail if CLI batch failed
    if !success
      self.fail("Error executing CLI batch `#{resource[:title]}`: #{output['failure-description']}") 
    end
  end
    
  # execute a batch based on the current and desired state
  #
  # current_batch_elements - the current state of the batch
  # new_batch_elements     - the desired state of the batch
  def execute_batch current_batch_elements, new_batch_elements

    # NOTE: really this should never happen, but let's be safe
    raise Puppet::Error, "jboss_batch - cli - execute_batch: new_batch_elements must have same number of elements as current_batch_elements" unless new_batch_elements.length == current_batch_elements.length

    # format all of the batches individual commands
    formated_commands = []
    current_batch_elements.zip(new_batch_elements).each do |current_batch_element, new_batch_element|

      # protect against the current and new batches getting out of order
      # NOTE: really this should never happen, but let's be safe
      unless (new_batch_element['address'] == current_batch_element['address'] &&
             new_batch_element['command'] == current_batch_element['command'])
            
        raise Puppet::Error, "jboss_batch - cli - execute_batch: Current Batch order out of sync with New batch order"
      end

      # if batch elment is a resource
      # else if batch element is a command
      # else error
      if new_batch_element.has_key?('address')

        # if the resource currently exists
        # else if the resource does not currently exist
        if current_batch_element['ensure'].to_sym == :present

          # if ensure the options on the existing resource are set correctly
          # else if ensure the resource does not exist
          if new_batch_element.has_key?('options') && ((new_batch_element['ensure'] || :present).to_sym == :present) 

            current_resource_options = current_batch_element['options']
            new_resource_options = new_batch_element['options']

            # determine attributes that need to be undefined
            undefines = new_resource_options.select{ |key, value| value == 'undefined' && current_resource_options[key]}.collect{ |key, value| key}
  
            # determine attributes who's values have changed
            changes = new_resource_options.to_a - current_resource_options.to_a

            # create formated commands
            formated_attribute_commands = changes.collect { |attribute, value|
              format_command new_batch_element['address'], 'write-attribute', {'name' => attribute, 'value' => value}
            }
            formated_attribute_commands += undefines.collect { |attribute|
              format_command new_batch_element['address'], 'undefine-attribute', {'name' => attribute}
            }

            formated_commands.push(formated_attribute_commands)
          elsif new_batch_element['ensure'].to_sym == :absent
            # remove the resource
            formated_command = format_command(new_batch_element['address'], 'remove')
            formated_commands.push(formated_command)
          end
        else
          # if ensure the resource exists
          # else ensure the resource does not exist
          if ((new_batch_element['ensure'] || :present).to_sym == :present)
            # add the resource with all specified options
            formated_command = format_command(new_batch_element['address'], 'add', new_batch_element['options'])
            formated_commands.push(formated_command)
          end
        end
      elsif new_batch_element.has_key?('command')
        # if command has option
        # else command has no options
        if new_batch_element.has_key?('options')
          parser = CliParser.new
          parsed_command = parser.parse_command new_batch_element['command']
          formated_command = format_command PathGenerator.format_path(parsed_command[0]), parsed_command[1], new_batch_element['options']
          formated_commands.push(formated_command)
        else
          formated_commands.push(new_batch_element['command'])
        end
      else
        # this error condition should have already been caught by now but throw it here just in case
        raise "Element of the batch is not recognized as a command or a resource, must specify either 'address' or 'command' respectivly: #{new_batch_element.inspect}"
      end
    end

    # execute all the commands as a batch
    formated_commands.reject! { |formated_command| formated_command.empty? }

    # execute all of the formated commands
    execute_cli get_server(resource), formated_commands, false, true
  end

  # executes a single command
  def execute_command command, arguments = nil 
    # don't try to execute a command if noop
    unless resource[:noop]
      if arguments
        parser = CliParser.new
        parsed_command = parser.parse_command command
        command = format_command PathGenerator.format_path(parsed_command[0]), parsed_command[1], arguments 
      end
      execute_cli get_server(resource), command, false
    end
  end
end
