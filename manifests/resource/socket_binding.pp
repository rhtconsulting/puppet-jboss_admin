# == Defines jboss_admin::socket_binding
#
# Configuration information for a socket.
#
# === Parameters
#
# [*client_mappings*]
#   Specifies zero or more client mappings for this socket binding. A client connecting to this socket should use the destination address specified in the mapping that matches its desired outbound interface. This allows for advanced network topologies that use either network address translation, or have bindings on multiple network interfaces to function. Each mapping should be evaluated in declared order, with the first successful match used to determine the destination.
#
# [*fixed_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other sockets in the socket group.
#
# [*interface*]
#   Name of the interface to which the socket should be bound, or, for multicast sockets, the interface on which it should listen. This should be one of the declared interfaces.
#
# [*multicast_address*]
#   Multicast address on which the socket should receive multicast traffic. If unspecified, the socket will not be configured to receive multicast.
#
# [*multicast_port*]
#   Port on which the socket should receive multicast traffic. Must be configured if 'multicast-address' is configured.
#
# [*resource_name*]
#   The name of the socket. Services which need to access the socket configuration information will find it using this name.
#
# [*port*]
#   Number of the port to which the socket should be bound.
#
#
define jboss_admin::resource::socket_binding (
  $server,
  $client_mappings                = undef,
  $fixed_port                     = undef,
  $interface                      = undef,
  $multicast_address              = undef,
  $multicast_port                 = undef,
  $resource_name                  = undef,
  $port                           = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $client_mappings != undef and $client_mappings != undefined and !is_array($client_mappings) {
      fail('The attribute client_mappings is not an array')
    }
    if $fixed_port != undef and $fixed_port != undefined {
      validate_bool($fixed_port)
    }
    if $multicast_port != undef and $multicast_port != undefined and !is_integer($multicast_port) {
      fail('The attribute multicast_port is not an integer')
    }
    if $port != undef and $port != undefined and !is_integer($port) {
      fail('The attribute port is not an integer')
    }

    $raw_options = {
      'client-mappings'              => $client_mappings,
      'fixed-port'                   => $fixed_port,
      'interface'                    => $interface,
      'multicast-address'            => $multicast_address,
      'multicast-port'               => $multicast_port,
      'name'                         => $resource_name,
      'port'                         => $port,
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
