# == Defines jboss_admin::cached_connection_manager
#
# Cached connection manager for resource adapters
#
# === Parameters
#
# [*debug*]
#   Enable/disable debug information logging
#
# [*error*]
#   Enable/disable error information logging
#
# [*install*]
#   Enable/disable the cached connection manager valve and interceptor
#
#
define jboss_admin::resource::cached_connection_manager (
  $server,
  $debug                          = undef,
  $error                          = undef,
  $install                        = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $debug != undef and $debug != undefined {
      validate_bool($debug)
    }
    if $error != undef and $error != undefined {
      validate_bool($error)
    }
    if $install != undef and $install != undefined {
      validate_bool($install)
    }

    $raw_options = {
      'debug'                        => $debug,
      'error'                        => $error,
      'install'                      => $install,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
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
