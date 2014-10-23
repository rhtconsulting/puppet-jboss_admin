# == Defines jboss_admin::authorization_ldap
#
# Configuration to use LDAP as the user repository.
#
# === Parameters
#
# [*connection*]
#   The name of the connection to use to connect to LDAP.
#
#
define jboss_admin::resource::authorization_ldap (
  $server,
  $connection                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $connection != undef and !is_string($connection) { 
      fail('The attribute connection is not a string') 
    }
  

    $raw_options = { 
      'connection'                   => $connection,
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
