require 'puppet/parser/functions'
require 'puppet/util/cli_execution'
require 'json'

Puppet::Type.type(:jboss_resource).provide(:cli) do
  desc "Manages JBoss container resources via the CLI"
  include Puppet::Util::CliExecution
  extend Puppet::Util::CliExecution

  def self.prefetch(resources)
    resources.each do |name, resource|
      # don't try to prefetch if noop
      unless resource[:noop]
        option_data = execute_cli get_server(resource), format_command(resource[:address], 'read-resource'), false
        attributes = {:name => name, :address => resource[:address]}
        if option_data['outcome'] == 'success'
          attributes[:ensure] = :present
          attributes[:options] = option_data['result']
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
