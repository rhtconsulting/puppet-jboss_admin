# == Defines jboss_admin::authentication_classic
#
# Traditional authentication configuration.  Configures a list of login modules to be used.
#
# === Parameters
#
# [*login_modules*]
#   List of authentication modules
#
#
define jboss_admin::resource::authentication_classic (
  $server,
  $login_modules                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $login_modules != undef and $login_modules != undefined and !is_array($login_modules) {
      fail('The attribute login_modules is not an array')
    }

    $raw_options = {
      'login-modules'                => $login_modules,
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
