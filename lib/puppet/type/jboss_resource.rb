# This is a workaround for bug: #4248 whereby ruby files outside of the normal
# provider/type path do not load until pluginsync has occured on the puppetmaster
#
# In this case I'm trying the relative path first, then falling back to normal
# mechanisms. This should be fixed in future versions of puppet but it looks
# like we'll need to maintain this for some time perhaps.
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),"..",".."))

Puppet::Type.newtype(:jboss_resource) do
  @doc = "A resource within a JBoss container"
  feature :treetop, "The treetop gem for resource parsing"


  ensurable

  newparam(:server) do
    desc "The Server instance that this resource should be managed in"
  end

  newparam(:address) do
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

    def change_to_s(current_value, new_value)
      changed_keys = (new_value.to_a - current_value.to_a).collect { |key, value|  key }

      current_value = current_value.delete_if { |key, value| !changed_keys.include? key}.inspect
      new_value = new_value.delete_if { |key, value| !changed_keys.include? key }.inspect

      super(current_value, new_value)
    end
  end

  newparam(:tries) do
    desc "The number of times applicaton of the resource should be tried.
          Defaults to '1'. This many attempts will be made to apply
          the resource until the resource application does not return a failure.
          Note that the timeout paramater applies to each try rather than
          to the complete set of tries."

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[\d]+$/
          raise ArgumentError, "Tries must be an integer"
        end
        value = Integer(value)
      end
      raise ArgumentError, "Tries must be an integer >= 1" if value < 1
      value
    end

    defaultto 1
  end

  newparam(:try_sleep) do
    desc "The time to sleep in seconds between 'tries'."

    munge do |value|
      if value.is_a?(String)
        unless value =~ /^[-\d.]+$/
          raise ArgumentError, "try_sleep must be a number"
        end
        value = Float(value)
      end
      raise ArgumentError, "try_sleep cannot be a negative number" if value < 0
      value
    end

    defaultto 0
  end

  def server_reference
    catalog.resource("Jboss_admin::Server[#{self[:server]}]")
  end

  autorequire(:jboss_resource) do
    require 'puppet/util/cli_parser'
    require 'puppet/util/path_generator'

    parser = CliParser.new
    resource_path = parser.parse_path value(:address)
    raise "Could not parse resource path #{value(:address)}, autorequire will fail" unless resource_path

    PathGenerator.ancestors resource_path
  end

  autorequire(:anchor) do
    ["Jboss_admin::Server[#{self[:server]}] End"]
  end
end
