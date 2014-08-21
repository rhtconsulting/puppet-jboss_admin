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
  $path                           = $name
) {
  if $ensure == present {

    if $outbound_socket_binding_ref != undef and !is_string($outbound_socket_binding_ref) { 
      fail('The attribute outbound_socket_binding_ref is not a string') 
    }
    if $security_realm != undef and !is_string($security_realm) { 
      fail('The attribute security_realm is not a string') 
    }
    if $username != undef and !is_string($username) { 
      fail('The attribute username is not a string') 
    }
  

    $raw_options = { 
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
      'security-realm'               => $security_realm,
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
