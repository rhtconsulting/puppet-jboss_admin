require 'puppet/parser/functions'
require 'puppet/util/cli_execution'
require 'json'

Puppet::Type.type(:jboss_resource).provide(:cli) do
  desc "Manages JBoss container resources via the CLI"
  include Puppet::Util::CliExecution
  extend Puppet::Util::CliExecution

  def self.prefetch(resources)
    cached_results = {}
    parser = CliParser.new

    resources.each do |name, resource|
      # don't try to prefetch if noop
      unless resource[:noop]
        if cached_results[resource[:server]].nil?
          cached_results[resource[:server]] = execute_cli get_server(resource), format_command('/', 'read-resource', {:recursive => true}), false
        end

        parsed_address = parser.parse_path(resource[:address]).collect{|entry| entry.to_a}.flatten
        search_pos = cached_results[resource[:server]]['result']

        parsed_address.each { |step|
          search_pos = search_pos[step]
          break if search_pos.nil?
        }

        attributes = {:name => name, :address => resource[:address]}
        if search_pos
          attributes[:ensure] = :present
          attributes[:options] = search_pos
        else
          attributes[:ensure] = :absent
        end

        resource.provider = new attributes
      end
    end
  end

  def initialize(value={})
    super(value)
    @new_values = {}
  end

  def create
    @new_values[:ensure] = :present
  end

  def destroy
    @new_values[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def options
    @property_hash[:options]
  end

  def options=(value)
    @new_values[:options] = value
  end

  def flush
    if @new_values[:ensure] == :absent
      result = execute_cli get_server(resource), format_command(resource[:address], 'remove')
      raise "Error removing resource" unless result['outcome'] == 'success'
      return
    elsif @new_values[:ensure] == :present
      result = execute_cli get_server(resource), format_command(resource[:address], 'add', resource[:options])
      raise "Error creating resource" unless result['outcome'] == 'success'
      return
    elsif @new_values[:options]
      undefines = @new_values[:options].select{ |key, value| value == 'undefined' && @property_hash[key]}.collect{ |key, value| key}
      changes = @new_values[:options].to_a - @property_hash[:options].to_a
      commands = changes.collect { |attribute, value| 
        format_command resource[:address], 'write-attribute', {'name' => attribute, 'value' => value}
      } + undefines.collect { |attribute|
        format_command resource[:address], 'undefine-attribute', {'name' => attribute}
      }

      result = execute_cli get_server(resource), commands, false, true
      raise "Failed setting attribute, #{result['failure-description']}" unless result['outcome'] == 'success'  
    end
  end

end
