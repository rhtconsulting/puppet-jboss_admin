# == Defines jboss_admin::socket-binding
#
# Configuration information for a socket.
#
# === Parameters
#
# [*port*]
#   Number of the port to which the socket should be bound.
#
# [*interface*]
#   Name of the interface to which the socket should be bound, or, for multicast sockets, the interface on which it should listen. This should be one of the declared interfaces.
#
# [*client_mappings*]
#   Specifies zero or more client mappings for this socket binding. A client connecting to this socket should use the destination address specified in the mapping that matches its desired outbound interface. This allows for advanced network topologies that use either network address translation, or have bindings on multiple network interfaces to function. Each mapping should be evaluated in declared order, with the first successful match used to determine the destination.
#
# [*multicast_address*]
#   Multicast address on which the socket should receive multicast traffic. If unspecified, the socket will not be configured to receive multicast.
#
# [*name*]
#   The name of the socket. Services which need to access the socket configuration information will find it using this name.
#
# [*multicast_port*]
#   Port on which the socket should receive multicast traffic. Must be configured if 'multicast-address' is configured.
#
# [*fixed_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other sockets in the socket group.
#
#
define jboss_admin::socket-binding (
  $server,
  $port                           = undef,
  $interface                      = undef,
  $client_mappings                = undef,
  $multicast_address              = undef,
  $name                           = undef,
  $multicast_port                 = undef,
  $fixed_port                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef && !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $multicast_port != undef && !is_integer($multicast_port) { 
      fail('The attribute multicast_port is not an integer') 
    }
  

    $raw_options = { 
      'port'                         => $port,
      'interface'                    => $interface,
      'client-mappings'              => $client_mappings,
      'multicast-address'            => $multicast_address,
      'name'                         => $name,
      'multicast-port'               => $multicast_port,
      'fixed-port'                   => $fixed_port,
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
