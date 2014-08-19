# == Defines jboss_admin::type_compilation
#
# The management interface for the compilation system of the Java virtual machine
#
# === Parameters
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*resource_name*]
#   The name of the Just-in-time (JIT) compiler.
#
# [*compilation_time_monitoring_supported*]
#   Whether the Java virtual machine supports the monitoring of compilation time.
#
#
define jboss_admin::resource::type_compilation (
  $server,
  $object_name                    = undef,
  $resource_name                  = undef,
  $compilation_time_monitoring_supported = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'object-name'                  => $object_name,
      'name'                         => $resource_name,
      'compilation-time-monitoring-supported' => $compilation_time_monitoring_supported,
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
