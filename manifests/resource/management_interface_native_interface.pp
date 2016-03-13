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
# [*sasl_protocol*]
#   The name of the protocol to be passed to the SASL mechanisms used for authentication.
#
# [*security_realm*]
#   The security realm to use for the native management interface.
#
# [*server_name*]
#   The name of the server used in the initial Remoting exchange and within the SASL mechanisms.
#
# [*socket_binding*]
#   The name of the socket binding configuration to use for the native management interface's socket.
#
#
define jboss_admin::resource::management_interface_native_interface (
  $server,
  $interface                      = undef,
  $port                           = undef,
  $sasl_protocol                  = undef,
  $security_realm                 = undef,
  $server_name                    = undef,
  $socket_binding                 = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $port != undef and $port != undefined and !is_integer($port) {
      fail('The attribute port is not an integer')
    }

    $raw_options = {
      'interface'                    => $interface,
      'port'                         => $port,
      'sasl-protocol'                => $sasl_protocol,
      'security-realm'               => $security_realm,
      'server-name'                  => $server_name,
      'socket-binding'               => $socket_binding,
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
