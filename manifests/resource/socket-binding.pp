# == Defines jboss_admin::socket-binding
#
# Configuration information for a socket.
#
# === Parameters
#
# [*port*]
#   Number of the port to which the socket should be bound.
#
# [*multicast_port*]
#   Port on which the socket should receive multicast traffic. Must be configured if 'multicast-address' is configured.
#
# [*fixed_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other sockets in the socket group.
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
# [*_name*]
#   The name of the socket. Services which need to access the socket configuration information will find it using this name.
#
#
define jboss_admin::resource::socket-binding (
  $server,
  $port                           = undef,
  $multicast_port                 = undef,
  $fixed_port                     = undef,
  $interface                      = undef,
  $client_mappings                = undef,
  $multicast_address              = undef,
  $_name                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $multicast_port != undef and !is_integer($multicast_port) { 
      fail('The attribute multicast_port is not an integer') 
    }
  

    $raw_options = { 
      'port'                         => $port,
      'multicast-port'               => $multicast_port,
      'fixed-port'                   => $fixed_port,
      'interface'                    => $interface,
      'client-mappings'              => $client_mappings,
      'multicast-address'            => $multicast_address,
      'name'                         => $_name,
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
