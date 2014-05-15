# == Defines jboss_admin::cached-connection-manager
#
# jca.cached-connection-manager
#
# === Parameters
#
# [*install*]
#   Enable/disable the cached connection manager valve and interceptor
#
# [*error*]
#   Enable/disable error information logging
#
# [*debug*]
#   Enable/disable debug information logging
#
#
define jboss_admin::resource::cached-connection-manager (
  $server,
  $install                        = undef,
  $error                          = undef,
  $debug                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'install'                      => $install,
      'error'                        => $error,
      'debug'                        => $debug,
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
