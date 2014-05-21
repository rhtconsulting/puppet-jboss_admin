require 'puppet/util/cli_parser'
require 'puppet/util/path_generator'

Puppet::Type.newtype(:jboss_resource) do
  @doc = "A resource within a JBoss container"

  ensurable

  newparam(:server) do
    desc "The Server instance that this resource should be managed in"
  end

  newparam(:address, :namevar=>true) do
    desc "The address of the resource, given in CLI format"
  end

  newproperty(:options) do
    desc "Hash of the attribute values that should exist on the resource"  

    defaultto {}
    validate do |value|
      value.is_a?(Hash)
    end

    def insync?(is)
      should_undefined_keys = should.select{ |key, value| value == 'undefined'}.collect{ |key, value| key}

      return false if should_undefined_keys.any?{|key, value| is[key]} 
      (should.select{ |key, value| value != 'undefined' }.to_a - is.to_a).empty?
    end

    #def is_to_s(is)
    #  is.delete_if{|key,value| !should.has_key? key }.inspect
    #end

    #def should_to_s(should)
    #  should.inspect
    #end

    def change_to_s(current_value, new_value)
      changed_keys = (new_value.to_a - current_value.to_a).collect { |key, value|  key }

      current_value = current_value.delete_if { |key, value| !changed_keys.include? key}.inspect
      new_value = new_value.delete_if { |key, value| !changed_keys.include? key }.inspect

      super(current_value, new_value)
    end
  end

  def server_reference
    catalog.resource("Jboss_admin::Server[#{self[:server]}]")
  end

  autorequire(:jboss_resource) do
    parser = CliParser.new
    resource_path = parser.parse_path value(:address)
    raise "Could not parse resource path #{value(:address)}, autorequire will fail" unless resource_path

    PathGenerator.ancestors resource_path
  end

  autorequire(:anchor) do
    ["Jboss_admin::Server[#{self[:server]}] End"]
  end
end
