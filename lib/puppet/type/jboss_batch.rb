# This is a workaround for bug: #4248 whereby ruby files outside of the normal
# provider/type path do not load until pluginsync has occured on the puppetmaster
#
# In this case I'm trying the relative path first, then falling back to normal
# mechanisms. This should be fixed in future versions of puppet but it looks
# like we'll need to maintain this for some time perhaps.
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..",".."))

Puppet::Type.newtype(:jboss_batch) do
  @doc = "Executes a batch of arbitrary commands and resources within a JBoss container"
  feature :treetop, "Treetop gem for parsing"

  #non-isomorphic types can have multiple instances with the same namevar
  @isomorphic = false

  newparam(:title, :namevar=>true) do
    desc "The name of this batch command"
  end

  newparam(:server) do
    desc "The Server instance that this resource should be managed in"
  end

  newproperty(:batch, :array_matching => :all) do
    desc "The ordered batch of commands and resources to execute and ensure"

    validate do |batch_element|
      raise ArgumentError, "Each element of the batch array must be a hash: #{batch_element.inspect}" unless batch_element.is_a?(Hash)
      raise ArgumentError, "Each element of the batch array must contain an 'address' or 'command' element: #{batch_element.inspect}" unless batch_element['address'].is_a?(String) || batch_element['command'].is_a?(String)
    end

    # if should execute this batch then return the super value,
    # else return should to make it look like we are already in sync
    #
    # NOTE: this is the same trickery/hackery that Puppet:Type:Exec does
    def retrieve
      if @resource.should_execute?
        return super()
      else
        return self.should
      end
    end

    def insync?(is)
      # if there is a current state then compare to desired state and determine if in sync
      # else there is no current state so must be out of sync
      if is
        insync = true
        
        # determine if each 'should' batch element is in sync with it's 'is' conterpart
        should.zip(is).each do |should_batch_element, is_batch_element|
          # if there are options to ensure are synced
          if should_batch_element.has_key?('options')
            # get the keys that should be undefined
            should_undefined_options = should_batch_element['options'].select{ |key, value| value == 'undefined'}.collect{ |key, value| key}
    
            # if any keys that should be undefined are defined, then not in sync
            # else if any keys that should be defined are not defined or have the wrong value, not in sync
            if should_undefined_options.any?{|key, value| is_batch_element['options'][key] }
              insync = false
            else
              out_of_sync_options = (should_batch_element['options'].select{ |key, value| value != 'undefined' }.to_a - is_batch_element['options'].to_a)
              insync = out_of_sync_options.empty?
            end
          end
  
          break unless insync
        end
  
        # return insync state
        insync
      else
        insync = false
      end
    end

    # puppet function
    #
    # Used to format the Notice message that is printed for when the resource is out of sync
    def change_to_s(current_value, new_value)
      # prevent changing the given values in place
      current_value = Marshal.load(Marshal.dump(current_value))
      new_value = Marshal.load(Marshal.dump(new_value))

      # iterate the current_value and the new_value at the same time
      current_value.zip(new_value).each do |current_batch_element, new_batch_element|
        # determien the changed keys
        if new_batch_element.has_key?('options')
          changed_option_keys = (new_batch_element['options'].to_a - current_batch_element['options'].to_a).collect { |key, value|  key }
        else
          changed_option_keys = {}
        end

        # only list changed options in the current batch element
        current_batch_element['options'] = current_batch_element['options'].delete_if { |key, value| !changed_option_keys.include? key}.inspect if current_batch_element.has_key?('options')

        # only list changed options in the new batch element
        new_batch_element['options'] = new_batch_element['options'].delete_if { |key, value| !changed_option_keys.include? key }.inspect if new_batch_element.has_key?('options')

        # if the new batch element does not have any options, delete the options from both the current and new batch elements for easier comparison
        if (!new_batch_element.has_key?('options') || new_batch_element['options'].empty?)
          current_batch_element.delete('options')
          new_batch_element.delete('options')
        end

        # if new and current batch elements are equal remove them from the list
        if new_batch_element == current_batch_element
          current_value.delete(current_batch_element)
          new_value.delete(new_batch_element)
        end
      end

      super(current_value.inspect, new_value.inspect)
    end
  end

  newparam(:expected_output) do
    desc "The hash output from the batch should contain a super set of the provided values."
    defaultto({"outcome"=>"success"})
  end

  newparam(:unless) do
    desc "If specified, the batch is only executed when this evaluates to false"
  end

  newparam(:onlyif) do
    desc "If specified, the batch is only executed when this evaluates to true"
  end

  newparam(:refreshonly) do
    desc "If true, this batch will only be executed when refreshed"
    defaultto false
    newvalues true, false
  end

  newparam(:logoutput) do
    desc 'Whether to log batch output in addition to logging the exit code. Defaults to `on_failure`, which only logs the output when the batch has an exit code that does not match any value specified by the returns attribute. As with any resource type, the log level can be controlled with the loglevel metaparameter.'

    defaultto :on_failure
    newvalues true, false, :on_failure
  end

  newparam(:tries) do
    desc "The number of times execution of the batch should be tried.
          Defaults to '1'. This many attempts will be made to execute
          the batch until the batch does not return a failure.
          Note that the timeout paramater applies to each try rather than
          to the complete set of tries."

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[\d]+$/
          raise ArgumentError, "Tries must be an integer"
        end
        value = Integer(value)
      end
      raise ArgumentError, "Tries must be an integer >= 1" if value < 1
      value
    end

    defaultto 1
  end

  newparam(:try_sleep) do
    desc "The time to sleep in seconds between 'tries'."

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[-\d.]+$/
          raise ArgumentError, "try_sleep must be a number"
        end
        value = Float(value)
      end
      raise ArgumentError, "try_sleep cannot be a negative number" if value < 0
      value
    end

    defaultto 0
  end

  def server_reference
    catalog.resource("Jboss_admin::Server[#{self[:server]}]")
  end

  def should_execute?(refreshing=false)
    require 'puppet/util/cli_parser'
    require 'puppet/util/path_generator'

    return false if self[:refreshonly] && !refreshing

    parser = CliParser.new
    if self[:onlyif]
      check = parser.parse_condition self[:onlyif]
      check_command = PathGenerator.format_command check[1][0], check[1][1], check[1][2]
      data = provider.execute_command check_command
      result = check[0].call data

      return false if !result
    end
    if self[:unless]
      check = parser.parse_condition self[:unless]
      check_command = PathGenerator.format_command check[1][0], check[1][1], check[1][2]
      data = provider.execute_command check_command
      result = check[0].call data

      return false if result
    end
    true
  end

  def refresh
    if should_execute? true
      self.property(:batch).sync
    end
  end

  autorequire(:jboss_resource) do
    require 'puppet/util/cli_parser'
    require 'puppet/util/path_generator'

    parser = CliParser.new

    unless_dependencies  = []
    onlyif_dependencies  = []

    # parse each individual command of the batch and get its ancestors
    batch_dependencies = value(:batch).collect { |batch_element|
      if batch_element.has_key?('address')
        address = batch_element['address']
        resource_path = parser.parse_path address
        raise "Could not parse resource path #{address}, autorequire will fail" unless resource_path

        PathGenerator.ancestors resource_path
      elsif batch_element.has_key?('command')
        command = batch_element['command']
        resource_path = parser.parse_command command
        raise "Could not parse batch sub-command #{value(command)}, autorequire will fail" unless resource_path

        PathGenerator.ancestors_and_self resource_path[0]
      else
        # this error condition should have already been caught by now but throw it here just in case
        raise "Element of the batch is not recognized as a command or a resource, must specify either 'address' or 'command' respectivly: #{batch_element.inspect}"
      end
    }
    batch_dependencies.flatten!

    if value(:onlyif)
      resource_path = parser.parse_condition value(:onlyif)
      raise "Could not parse condition #{value(:onlyif)}, autorequire will fail" unless resource_path
      onlyif_dependencies = PathGenerator.ancestors_and_self resource_path[1][0]
    end

    if value(:unless)
      resource_path = parser.parse_condition value(:unless)
      raise "Could not parse condition #{value(:unless)}, autorequire will fail" unless resource_path
      unless_dependencies = PathGenerator.ancestors_and_self resource_path[1][0]
    end

    batch_dependencies | onlyif_dependencies | unless_dependencies
  end

  autorequire(:anchor) do
    ["Jboss_admin::Server[#{self[:server]}] End"]
  end
end
