module Puppet::Util::CliExecution

  def get_server(resource)
    server = resource.server_reference
    raise "A server reference is required to manage resources" unless server
    server
  end

  def convert_ints_to_strings(value)
    return value.to_s unless value.is_a?(TrueClass) || value.is_a?(FalseClass) || value.is_a?(Hash) || value.is_a?(Array) || value.nil?

    if value.is_a? Hash
      value.each { |k, v| value[k] = convert_ints_to_strings(v) }
    elsif value.is_a? Array
      value.collect { |v| convert_ints_to_strings v }
    else
      value
    end
  end

  def execute_cli(server, command, failonfail = true, batch = false)
    cli_path = "#{server['base_path']}/bin/jboss-cli.sh"
    command_file = Tempfile.new 'clicommands'
    command_file.chmod 0644
    command_file.write "batch\n" if batch
    command_file.write command if command.is_a? String
    command_file.write command.join("\n") if command.is_a? Array
    command_file.write "\nrun-batch\n" if batch
    command_file.close

    delete_nil = Proc.new { |k, v| v.kind_of?(Hash) ? (v.delete_if(&delete_nil); nil) : v.nil? }

    output = execute [cli_path, '--connect','--controller=' + server['management_ip'] + ':' + server['management_port'], '--file=' + command_file.path], {:failonfail => failonfail, :combine => true}

    if batch
      return {'outcome' => 'success'} if output =~ /The batch executed successfully/
      return {'outcome' => 'failure', 'failure-description' => output.lines.to_a.last}
    else
      json_string = '[' + output.gsub(/ => undefined/, ': null').gsub(/=>/, ':').gsub(/: expression/, ': ').gsub(/\}\n\{/m, "},{").gsub(/\n/, '') + ']'
      parsed_output = JSON.parse(json_string)
      parsed_output = parsed_output.collect {|o| o.delete_if &delete_nil}
      parsed_output = parsed_output.collect {|o| convert_ints_to_strings o }

      return parsed_output.first if parsed_output.count == 1
      parsed_output
    end
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
