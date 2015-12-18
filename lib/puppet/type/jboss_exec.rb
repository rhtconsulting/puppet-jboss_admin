# This is a workaround for bug: #4248 whereby ruby files outside of the normal
# provider/type path do not load until pluginsync has occured on the puppetmaster
#
# In this case I'm trying the relative path first, then falling back to normal
# mechanisms. This should be fixed in future versions of puppet but it looks
# like we'll need to maintain this for some time perhaps.
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..",".."))

Puppet::Type.newtype(:jboss_exec) do
  @doc = "Executes an arbitrary command within a JBoss container"
  feature :treetop, "Treetop gem for parsing"

  #non-isomorphic types can have multiple instances with the same namevar
  @isomorphic = false

  newparam(:server) do
    desc "The Server instance that this resource should be managed in"
  end

  newparam(:command, :namevar=>true) do
    desc "The command to execute, given in CLI format"
  end

  newparam(:expected_output) do
    desc "The hash output from the command should contain a super set of the provided values."
    defaultto({"outcome"=>"success"})
  end


  newparam(:arguments) do
    desc "Arguments to be appended to the command"
  end

  newparam(:unless) do
    desc "If specified, the command is only executed when this evaluates to false"
  end

  newparam(:onlyif) do
    desc "If specified, the command is only executed when this evaluates to true"
  end

  newparam(:refreshonly) do
    desc "If true, this command will only be executed when refreshed"
    defaultto false
    newvalues true, false
  end

  newparam(:logoutput) do
    desc 'Whether to log command output in addition to logging the exit code. Defaults to `on_failure`, which only logs the output when the command has an exit code that does not match any value specified by the returns attribute. As with any resource type, the log level can be controlled with the loglevel metaparameter.'

    defaultto :on_failure
    newvalues true, false, :on_failure
  end

  newparam(:tries) do
    desc "The number of times execution of the command should be tried.
          Defaults to '1'. This many attempts will be made to execute
          the command until the command does not return a failure.
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

  newproperty(:executed, :boolean => true) do
    defaultto true

    def retrieve
      not @resource.should_execute?
    end

    def sync
      tries = self.resource[:tries]
      try_sleep = self.resource[:try_sleep]
      
      output = nil
      last_error = nil
      
      # attempt to CLI command for each try.  Retry needs to be done at this level
      #to handle the case where the received output is not the expected output from the command
      #(command execution succeeds without cli timeout, but the result isnt what we expected)
      tries.times do |try|
        begin
          # Only add debug messages for tries > 1 to reduce log spam.
          debug("Exec try #{try+1}/#{tries}") if tries > 1
          
          # run the command
          output = provider.execute_command(resource[:command], resource[:arguments])
          
          # break the try loop if command was a success
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
        self.fail("Error executing CLI command `#{resource[:command]}`: #{last_error}")
      end
      
      # determine if the execution was a success
      success = (resource[:expected_output].to_a - output.to_a).empty?

      # log output if required
      if (resource[:logoutput] == :true || (!success && resource[:logoutput] == :on_failure))
        self.send(@resource[:loglevel], output.inspect)
      end

      # fail if CLI command failed
      if !success
        expected_output = resource[:expected_output].pretty_inspect
        received_output = output.pretty_inspect
        self.fail("Error executing CLI command `#{resource[:command]}`:\n Expected output: #{expected_output}\n Received output:\n #{received_output} \n Failure desc:\n #{output['failure-description']}") 
      end
    end
  end

  def should_execute?(refreshing=false)
    require 'puppet/util/cli_parser'
    require 'puppet/util/path_generator'

    return false if self[:refreshonly] && !refreshing

    parser = CliParser.new
    if self[:onlyif]
      check = parser.parse_condition self[:onlyif]
      check_command = PathGenerator.format_command check[1][0], check[1][1], check[1][2]
      data = provider.execute_command check_command,nil,self[:tries],self[:try_sleep]
      result = check[0].call data

      return false if !result
    end
    if self[:unless]
      check = parser.parse_condition self[:unless]
      check_command = PathGenerator.format_command check[1][0], check[1][1], check[1][2]
      data = provider.execute_command check_command,nil,self[:tries],self[:try_sleep]
      result = check[0].call data

      return false if result
    end
    true
  end

  def refresh
    if should_execute? true
      self.property(:executed).sync
    end
  end

  autorequire(:jboss_resource) do
    require 'puppet/util/cli_parser'
    require 'puppet/util/path_generator'

    parser = CliParser.new
    resource_path = parser.parse_command value(:command)
    raise "Could not parse command #{value(:command)}, autorequire will fail" unless resource_path

    command_dependencies = PathGenerator.ancestors_and_self resource_path[0]
    unless_dependencies  = []
    onlyif_dependencies  = []

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

    command_dependencies | onlyif_dependencies | unless_dependencies
  end

  autorequire(:anchor) do
    ["Jboss_admin::Server[#{self[:server]}] End"]
  end
end
