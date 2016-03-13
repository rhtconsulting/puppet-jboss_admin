# == Defines jboss_admin::file_data_store
#
# A JVM local file store that stores persistent EJB timers
#
# === Parameters
#
# [*path*]
#   The directory to store persistent timer information in
#
# [*relative_to*]
#   The relative path that is used to resolve the timer data store location
#
#
define jboss_admin::resource::file_data_store (
  $server,
  $path                           = undef,
  $relative_to                    = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'path'                         => $path,
      'relative-to'                  => $relative_to,
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
