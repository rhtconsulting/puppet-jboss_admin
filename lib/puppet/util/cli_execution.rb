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

  def execute_cli(server, command, failonfail = true, batch = false, tries = 3 , try_sleep = 1)
    output = ""
    tries = tries.to_i
    try_sleep = try_sleep.to_i
    cli_path = "#{server['base_path']}/bin/jboss-cli.sh"
    command_file = Tempfile.new 'clicommands'
    command_file.chmod 0644
    command_file.write "batch\n" if batch
    command_file.write command if command.is_a? String
    command_file.write command.join("\n") if command.is_a? Array
    command_file.write "\nrun-batch\n" if batch
    command_file.close

    delete_nil = Proc.new { |k, v| v.kind_of?(Hash) ? (v.delete_if(&delete_nil); nil) : v.nil? }

    tries.times { |try|
      output = execute [ 'timeout', "#{server['cli_execute_timeout_minutes']}m", cli_path, '--connect','--controller=' + server['management_ip'] + ':' + server['management_port'], '--file=' + command_file.path], {:failonfail => failonfail, :combine => true}

      if batch
        #in batch mode, we either exit on a success or we keep retrying up until our
        #retries are exhausted
        return {'outcome' => 'success'} if output =~ /The batch executed successfully/
        if try >= (tries - 1)
          return {'outcome' => 'failure', 'failure-description' => output.lines.to_a}
        end
        #else, retry
      else
        json_string = '[' + output.gsub(/ => undefined/, ': null').gsub(/=>/, ':').gsub(/: expression/, ': ').gsub(/\}\n\{/m, "},{").gsub(/\n/, '').gsub(/ (-?\d+)L/, ' \1').gsub(/bytes\s*\{([^\}]*)\}/,'"bytes {\1}"') + ']'

        begin
          parsed_output = JSON.parse(json_string)
          parsed_output = parsed_output.collect {|o| o.delete_if &delete_nil}
          parsed_output = parsed_output.collect {|o| convert_ints_to_strings o }
          if parsed_output.count == 1
            return parsed_output.first
          else
            return parsed_output
          end
        rescue JSON::ParserError => e
          #this is a retryable error, the loop will continue and try again
          #unless we have exhausted all tries, then just print the output
          #from the raise at the bottom of this function
          debug("Handled a JSON parse error in execute_cli:\n #{e.to_s}")
        end
      end

      #for non-batch commands, we use a JSON::ParseError to detect when a stack trace
      #is emitted from the execution, this will cause us to retry the command.
      debug("Possible cli timeout while in execute_cli for command #{command}, retrying #{try+1}/#{tries}")
      # sleep before next attempt
      if try_sleep > 0 and tries > 1
        debug("Sleeping for #{try_sleep} seconds between tries")
        sleep try_sleep
      end
    }

    #if we get here, then all retries failed and we should raise an exception
    raise "All retries (amount: #{tries}) exhausted executing #{command}.  Last output:\n #{output}"
  end

  def format_value(value)
    if value.is_a?(Array) || value.is_a?(Hash)
      value = value.inspect
    else
      # if the value contains double quotes escape them
      # NOTE: be sure this is done before wrapping the string in quotes
      value = value.to_s.gsub(/"/,'\"')

      # if the value contains special characters then wrap it in quotes
      value = (/[${}, =\[\]]/ =~ value.to_s).nil? ? value.to_s : "\"#{value.to_s}\""
    end

    return value
  end

  def format_command(address, operation, options = {})
    if options.nil? || options.empty?
      "#{address}:#{operation}"
    else
      option_string = options.map{ |option, value| "#{option}=#{format_value value}" }.join(',')
      "#{address}:#{operation}(#{option_string})"
    end
  end
end
