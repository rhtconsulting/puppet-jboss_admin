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
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'login-modules'                => $login_modules,
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
