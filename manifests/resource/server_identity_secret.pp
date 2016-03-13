# == Defines jboss_admin::server_identity_secret
#
# Configuration of the secret/password-based identity of a server or host controller.
#
# === Parameters
#
# [*value*]
#   The secret / password - Base64 Encoded.
#
#
define jboss_admin::resource::server_identity_secret (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'value'                        => $value,
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
