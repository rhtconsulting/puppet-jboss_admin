# == Defines jboss_admin::management_interface_http_interface
#
# Configuration of the server's HTTP management interface
#
# === Parameters
#
# [*console_enabled*]
#   Flag that indicates admin console is enabled
#
# [*interface*]
#   Deprecated -- use 'socket-binding'. The network interface on which the server's socket for HTTP management communication should be opened. Must be 'undefined' if the 'socket-binding' or 'secure-socket-binding' attribute is set.
#
# [*port*]
#   Deprecated -- use 'socket-binding'. The port on which the server's socket for HTTP management communication should be opened. Must be 'undefined' if the 'socket-binding' attribute is set.
#
# [*secure_port*]
#   Deprecated -- use 'secure-socket-binding'. The port on which the server's socket for HTTPS management communication should be opened. Must be 'undefined' if the 'socket-binding' or 'secure-socket-binding' attribute is set.
#
# [*secure_socket_binding*]
#   The name of the socket binding configuration to use for the HTTPS management interface's socket.
#
# [*security_realm*]
#   The security realm to use for the HTTP management interface.
#
# [*socket_binding*]
#   The name of the socket binding configuration to use for the HTTP management interface's socket.
#
#
define jboss_admin::resource::management_interface_http_interface (
  $server,
  $console_enabled                = undef,
  $interface                      = undef,
  $port                           = undef,
  $secure_port                    = undef,
  $secure_socket_binding          = undef,
  $security_realm                 = undef,
  $socket_binding                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $console_enabled != undef { 
      validate_bool($console_enabled)
    }
    if $interface != undef and !is_string($interface) { 
      fail('The attribute interface is not a string') 
    }
    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $secure_port != undef and !is_integer($secure_port) { 
      fail('The attribute secure_port is not an integer') 
    }
    if $secure_socket_binding != undef and !is_string($secure_socket_binding) { 
      fail('The attribute secure_socket_binding is not a string') 
    }
    if $security_realm != undef and !is_string($security_realm) { 
      fail('The attribute security_realm is not a string') 
    }
    if $socket_binding != undef and !is_string($socket_binding) { 
      fail('The attribute socket_binding is not a string') 
    }
  

    $raw_options = { 
      'console-enabled'              => $console_enabled,
      'interface'                    => $interface,
      'port'                         => $port,
      'secure-port'                  => $secure_port,
      'secure-socket-binding'        => $secure_socket_binding,
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
