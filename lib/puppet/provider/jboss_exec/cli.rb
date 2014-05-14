require 'puppet/util/cli_execution'

Puppet::Type.type(:jboss_exec).provide(:cli) do
  include Puppet::Util::CliExecution

  def execute_command command
    execute_cli get_server(resource), command
  end
end
