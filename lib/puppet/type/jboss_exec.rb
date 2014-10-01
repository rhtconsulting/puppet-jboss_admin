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

  newparam(:server) do
    desc "The Server instance that this resource should be managed in"
  end

  newparam(:command, :namevar=>true) do
    desc "The command to execute, given in CLI format"
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

  def server_reference
    catalog.resource("Jboss_admin::Server[#{self[:server]}]")
  end

  newproperty(:executed, :boolean => true) do
    defaultto true

    def retrieve
      not @resource.should_execute?
    end

    def sync
      output = provider.execute_command(resource[:command])
      if (resource[:logoutput] == :true || (output['outcome'] == 'failed' && resource[:logoutput] == :on_failure))
        self.send(@resource[:loglevel], output.inspect)
      end
      if output['outcome'] == 'failed'
        self.fail("Error executing CLI command `#{resource[:command]}`: #{output['failure-description']}") 
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
