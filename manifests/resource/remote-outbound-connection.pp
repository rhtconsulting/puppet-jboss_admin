# == Defines jboss_admin::remote-outbound-connection
#
# Remoting outbound connection with a implicit remote:// URI scheme.
#
# === Parameters
#
# [*security_realm*]
#   Reference to the security realm to use to obtain the password and SSL configuration.
#
# [*outbound_socket_binding_ref*]
#   Name of the outbound-socket-binding which will be used to determine the destination address and port for the connection.
#
# [*username*]
#   The user name to use when authenticating against the remote server.
#
#
define jboss_admin::resource::remote-outbound-connection (
  $server,
  $security_realm                 = undef,
  $outbound_socket_binding_ref    = undef,
  $username                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'security-realm'               => $security_realm,
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'username'                     => $username,
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
