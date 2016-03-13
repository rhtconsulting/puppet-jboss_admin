# == Defines jboss_admin::authentication_jaspi
#
# JASPI authentication configuration.
#
# === Parameters
#
# [*auth_modules*]
#   List of authentication modules to be used.
#
#
define jboss_admin::resource::authentication_jaspi (
  $server,
  $auth_modules                   = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $auth_modules != undef and $auth_modules != undefined and !is_array($auth_modules) {
      fail('The attribute auth_modules is not an array')
    }

    $raw_options = {
      'auth-modules'                 => $auth_modules,
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
