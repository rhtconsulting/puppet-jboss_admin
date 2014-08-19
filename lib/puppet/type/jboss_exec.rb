require 'puppet/util/cli_parser'
require 'puppet/util/path_generator'

Puppet::Type.newtype(:jboss_exec) do
  @doc = "Executes an arbitrary command within a JBoss container"

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

  def server_reference
    catalog.resource("Jboss_admin::Server[#{self[:server]}]")
  end

  newproperty(:executed, :boolean => true) do
    defaultto true

    def retrieve
      not @resource.should_execute?
    end

    def sync
      provider.execute_command(resource[:command])
    end
  end

  def should_execute?(refreshing=false)
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
