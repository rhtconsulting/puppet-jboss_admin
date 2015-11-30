require 'puppet/util/cli_execution'
require 'puppet/util/cli_parser'
require 'puppet/util/path_generator'

Puppet::Type.type(:jboss_exec).provide(:cli) do
  include Puppet::Util::CliExecution

  def execute_command command, arguments = nil, retries = 1, try_sleep = 1
    # don't try to execute a command if noop
    unless resource[:noop]
      if arguments
        parser = CliParser.new
        parsed_command = parser.parse_command command
        command = format_command PathGenerator.format_path(parsed_command[0]), parsed_command[1], arguments 
      end
      execute_cli get_server(resource), command, false, false, retries, try_sleep
    end
  end
end
