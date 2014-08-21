# == Defines jboss_admin::type_operating_system
#
# The management interface for the operating system on which the Java virtual machine is running.
#
# === Parameters
#
# [*arch*]
#   The operating system architecture. If a security manager is installed and it does not allow access to system property "os.arch", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*resource_name*]
#   The operating system name. If a security manager is installed and it does not allow access to system property "os.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*version*]
#   The operating system version. If a security manager is installed and it does not allow access to system property "os.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
#
define jboss_admin::resource::type_operating_system (
  $server,
  $arch                           = undef,
  $resource_name                  = undef,
  $object_name                    = undef,
  $version                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $arch != undef and !is_string($arch) { 
      fail('The attribute arch is not a string') 
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
    if $object_name != undef and !is_string($object_name) { 
      fail('The attribute object_name is not a string') 
    }
    if $version != undef and !is_string($version) { 
      fail('The attribute version is not a string') 
    }
  

    $raw_options = { 
      'arch'                         => $arch,
      'name'                         => $resource_name,
      'object-name'                  => $object_name,
      'version'                      => $version,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
