# == Defines jboss_admin::user
#
# An authorized user.
#
# === Parameters
#
# [*password*]
#   The user's password.
#
#
define jboss_admin::resource::user (
  $server,
  $password                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {


    $raw_options = {
      'password'                     => $password,
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
