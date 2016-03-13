# == Defines jboss_admin::jsse
#
# JSSE configuration. Configures attributes for keystores that can be used for setting up SSL.
#
# === Parameters
#
# [*additional_properties*]
#   Additional properties that may be necessary to configure JSSE.
#
# [*cipher_suites*]
#   Comma separated list of cipher suites to enable on SSLSockets.
#
# [*client_alias*]
#   Preferred alias to use when the KeyManager chooses the client alias.
#
# [*client_auth*]
#   Boolean attribute to indicate if client's certificates should also be authenticated on the server side.
#
# [*key_manager*]
#   JSEE Key Manager factory
#
# [*keystore*]
#   Configures a JSSE key store
#
# [*protocols*]
#   Comma separated list of protocols to enable on SSLSockets.
#
# [*server_alias*]
#   Preferred alias to use when the KeyManager chooses the server alias.
#
# [*service_auth_token*]
#   Token to retrieve PrivateKeys from the KeyStore.
#
# [*trust_manager*]
#   JSEE Trust Manager factory
#
# [*truststore*]
#   Configures a JSSE trust store
#
#
define jboss_admin::resource::jsse (
  $server,
  $additional_properties          = undef,
  $cipher_suites                  = undef,
  $client_alias                   = undef,
  $client_auth                    = undef,
  $key_manager                    = undef,
  $keystore                       = undef,
  $protocols                      = undef,
  $server_alias                   = undef,
  $service_auth_token             = undef,
  $trust_manager                  = undef,
  $truststore                     = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $client_auth != undef and $client_auth != undefined {
      validate_bool($client_auth)
    }

    $raw_options = {
      'additional-properties'        => $additional_properties,
      'cipher-suites'                => $cipher_suites,
      'client-alias'                 => $client_alias,
      'client-auth'                  => $client_auth,
      'key-manager'                  => $key_manager,
      'keystore'                     => $keystore,
      'protocols'                    => $protocols,
      'server-alias'                 => $server_alias,
      'service-auth-token'           => $service_auth_token,
      'trust-manager'                => $trust_manager,
      'truststore'                   => $truststore,
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
