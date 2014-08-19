# == Defines jboss_admin::type_operating_system
#
# The management interface for the operating system on which the Java virtual machine is running.
#
# === Parameters
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*arch*]
#   The operating system architecture. If a security manager is installed and it does not allow access to system property "os.arch", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*version*]
#   The operating system version. If a security manager is installed and it does not allow access to system property "os.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*resource_name*]
#   The operating system name. If a security manager is installed and it does not allow access to system property "os.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
#
define jboss_admin::resource::type_operating_system (
  $server,
  $object_name                    = undef,
  $arch                           = undef,
  $version                        = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'object-name'                  => $object_name,
      'arch'                         => $arch,
      'version'                      => $version,
      'name'                         => $resource_name,
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
