# == Defines jboss_admin::server_imap
#
# Mail session server
#
# === Parameters
#
# [*password*]
#   Password to authenticate on server
#
# [*username*]
#   Username to authenticate on server
#
# [*outbound_socket_binding_ref*]
#   Outbound Socket binding to POP3 server
#
# [*ssl*]
#   Does server requires SSL?
#
#
define jboss_admin::resource::server_imap (
  $server,
  $password                       = undef,
  $username                       = undef,
  $outbound_socket_binding_ref    = undef,
  $ssl                            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'password'                     => $password,
      'username'                     => $username,
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'ssl'                          => $ssl,
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
