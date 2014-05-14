require 'treetop'
require File.expand_path('../cli_parser/cli_path', __FILE__)
require File.expand_path('../cli_parser/cli_command', __FILE__)
require File.expand_path('../cli_parser/cli_condition', __FILE__)

class CliParser
  def initialize()
    @path_parser = nil
    @command_parser = nil
    @condition_parser = nil
  end

  def path_parser
    @path_parser ||= CliPathParser.new
  end

  def command_parser
    @command_parser ||= CliCommandParser.new
  end

  def condition_parser
    @condition_parser ||= CliConditionParser.new
  end

  def parse_path(input)
    path_parser.parse(input).value
  end

  def parse_command(input)
    command_parser.parse(input).value
  end

  def parse_condition(input)
    condition_parser.parse(input).value
  end

end
