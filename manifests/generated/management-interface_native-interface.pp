# == Defines jboss_admin::management-interface_native-interface
#
# Configuration of the server's native management interface
#
# === Parameters
#
# [*port*]
#   Deprecated -- use 'socket-binding'. The port on which the server's socket for native management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*interface*]
#   Deprecated -- use 'socket-binding'. The network interface on which the server's socket for native management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*security_realm*]
#   The security realm to use for the native management interface.
#
# [*socket_binding*]
#   The name of the socket binding configuration to use for the native management interface's socket.
#
#
define jboss_admin::management-interface_native-interface (
  $server,
  $port                           = undef,
  $interface                      = undef,
  $security_realm                 = undef,
  $socket_binding                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef && !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
  

    $raw_options = { 
      'port'                         => $port,
      'interface'                    => $interface,
      'security-realm'               => $security_realm,
      'socket-binding'               => $socket_binding,
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
