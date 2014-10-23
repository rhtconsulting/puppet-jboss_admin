# == Defines jboss_admin::management_interface_native_interface
#
# Configuration of the server's native management interface
#
# === Parameters
#
# [*interface*]
#   Deprecated -- use 'socket-binding'. The network interface on which the server's socket for native management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*port*]
#   Deprecated -- use 'socket-binding'. The port on which the server's socket for native management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*security_realm*]
#   The security realm to use for the native management interface.
#
# [*socket_binding*]
#   The name of the socket binding configuration to use for the native management interface's socket.
#
#
define jboss_admin::resource::management_interface_native_interface (
  $server,
  $interface                      = undef,
  $port                           = undef,
  $security_realm                 = undef,
  $socket_binding                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $interface != undef and !is_string($interface) { 
      fail('The attribute interface is not a string') 
    }
    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $security_realm != undef and !is_string($security_realm) { 
      fail('The attribute security_realm is not a string') 
    }
    if $socket_binding != undef and !is_string($socket_binding) { 
      fail('The attribute socket_binding is not a string') 
    }
  

    $raw_options = { 
      'interface'                    => $interface,
      'port'                         => $port,
      'security-realm'               => $security_realm,
      'socket-binding'               => $socket_binding,
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
