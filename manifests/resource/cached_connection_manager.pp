# == Defines jboss_admin::cached_connection_manager
#
# jca.cached-connection-manager
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
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'debug'                        => $debug,
      'error'                        => $error,
      'install'                      => $install,
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
