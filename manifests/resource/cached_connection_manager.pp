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
  $path                           = $name
) {
  if $ensure == present {

    if $debug != undef and !is_bool($debug) { 
      fail('The attribute debug is not a boolean') 
    }
    if $error != undef and !is_bool($error) { 
      fail('The attribute error is not a boolean') 
    }
    if $install != undef and !is_bool($install) { 
      fail('The attribute install is not a boolean') 
    }
  

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
