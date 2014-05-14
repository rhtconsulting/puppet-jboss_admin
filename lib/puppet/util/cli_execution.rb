module Puppet::Util::CliExecution

  def get_server(resource)
    server = resource.server_reference
    raise "A server reference is required to manage resources" unless server
    server
  end

  def convert_ints_to_strings(value)
    return value.to_s unless value.is_a?(TrueClass) || value.is_a?(FalseClass) || value.is_a?(Hash) || value.nil?
    return value unless value.is_a? Hash

    value.each { |k, v| value[k] = convert_ints_to_strings(v) }
  end

  def execute_cli(server, command, failonfail = true)
    cli_path = "#{server['base_path']}/bin/jboss-cli.sh"
    command_file = Tempfile.new 'clicommands'
    command_file.chmod 0644
    command_file.write command if command.is_a? String
    command_file.write command.join("\n") if command.is_a? Array
    command_file.close

    delete_nil = Proc.new { |k, v| v.kind_of?(Hash) ? (v.delete_if(&delete_nil); nil) : v.nil? }

    FileUtils.copy command_file.path, '/tmp/cli_backup'
    output = execute [cli_path, '--connect', '--file=' + command_file.path], {:failonfail => failonfail, :combine => true, :uid => 502}
    command_file.unlink
    json_string = '[' + output.gsub(/ => undefined/, ': null').gsub(/=>/, ':').gsub(/\}\n\{/m, "},{").gsub(/\n/, '') + ']'
    parsed_output = JSON.parse(json_string)
    parsed_output = parsed_output.collect {|o| o.delete_if &delete_nil}
    parsed_output = parsed_output.collect {|o| convert_ints_to_strings o }

    return parsed_output.first if parsed_output.count == 1
    parsed_output
  end

  def format_value(value)
    if value.is_a?(Array) || value.is_a?(Hash)
      value.inspect
    else
      value.to_s
    end
  end

  def format_command(address, operation, options = {})
    if options.empty?
      "#{address}:#{operation}"
    else
      option_string = options.map{ |option, value| "#{option}=#{format_value value}" }.join(',')
      "#{address}:#{operation}(#{option_string})"
    end
  end
end
