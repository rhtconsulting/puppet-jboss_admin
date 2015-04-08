# == Defines jboss_admin::custom
#
# Mail session server
#
# === Parameters
#
# [*outbound_socket_binding_ref*]
#   Outbound Socket binding to mail server
#
# [*password*]
#   Password to authenticate on server
#
# [*properties*]
#   JavaMail properties
#
# [*ssl*]
#   Does server require SSL?
#
# [*tls*]
#   Does server require TLS?
#
# [*username*]
#   Username to authenticate on server
#
#
define jboss_admin::resource::custom (
  $server,
  $outbound_socket_binding_ref    = undef,
  $password                       = undef,
  $properties                     = undef,
  $ssl                            = undef,
  $tls                            = undef,
  $username                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $ssl != undef and $ssl != undefined {
      validate_bool($ssl)
    }
    if $tls != undef and $tls != undefined {
      validate_bool($tls)
    }
  

    $raw_options = {
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'password'                     => $password,
      'properties'                   => $properties,
      'ssl'                          => $ssl,
      'tls'                          => $tls,
      'username'                     => $username,
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
