# == Defines jboss_admin::remote_outbound_connection
#
# Remoting outbound connection with a implicit remote:// URI scheme.
#
# === Parameters
#
# [*outbound_socket_binding_ref*]
#   Name of the outbound-socket-binding which will be used to determine the destination address and port for the connection.
#
# [*security_realm*]
#   Reference to the security realm to use to obtain the password and SSL configuration.
#
# [*username*]
#   The user name to use when authenticating against the remote server.
#
#
define jboss_admin::resource::remote_outbound_connection (
  $server,
  $outbound_socket_binding_ref    = undef,
  $security_realm                 = undef,
  $username                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = {
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'security-realm'               => $security_realm,
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
