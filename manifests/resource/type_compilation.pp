# == Defines jboss_admin::type_compilation
#
# The management interface for the compilation system of the Java virtual machine
#
# === Parameters
#
# [*compilation_time_monitoring_supported*]
#   Whether the Java virtual machine supports the monitoring of compilation time.
#
# [*resource_name*]
#   The name of the Just-in-time (JIT) compiler.
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
#
define jboss_admin::resource::type_compilation (
  $server,
  $compilation_time_monitoring_supported = undef,
  $resource_name                  = undef,
  $object_name                    = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $compilation_time_monitoring_supported != undef and $compilation_time_monitoring_supported != undefined {
      validate_bool($compilation_time_monitoring_supported)
    }

    $raw_options = {
      'compilation-time-monitoring-supported' => $compilation_time_monitoring_supported,
      'name'                         => $resource_name,
      'object-name'                  => $object_name,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }
}
