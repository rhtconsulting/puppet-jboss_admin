# == Defines jboss_admin::authentication_kerberos
#
# Configuration to use Kerberos to authenticate the users.
#
# === Parameters
#
# [*remove_realm*]
#   After authentication should the realm name be stripped from the users name.
#
#
define jboss_admin::resource::authentication_kerberos (
  $server,
  $remove_realm                   = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $remove_realm != undef and $remove_realm != undefined {
      validate_bool($remove_realm)
    }

    $raw_options = {
      'remove-realm'                 => $remove_realm,
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
