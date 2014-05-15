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

  def parse(parser, input)
    result = parser.parse input
    raise "#{parser.failure_reason}: #{input}" if !result
    result.value
  end

  def parse_path(input)
    parse path_parser, input
  end

  def parse_command(input)
    parse command_parser, input
  end

  def parse_condition(input)
    parse condition_parser, input
  end

end
