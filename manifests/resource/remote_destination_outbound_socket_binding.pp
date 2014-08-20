# == Defines jboss_admin::remote_destination_outbound_socket_binding
#
# Configuration information for a, remote destination, outbound socket binding.
#
# === Parameters
#
# [*fixed_source_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other outbound sockets in the socket group.
#
# [*host*]
#   The host name or the IP address of the remote destination to which this outbound socket will connect.
#
# [*port*]
#   The port number of the remote destination to which the outbound socket should connect.
#
# [*source_interface*]
#   The name of the interface which will be used for the source address of the outbound socket.
#
# [*source_port*]
#   The port number which will be used as the source port of the outbound socket.
#
#
define jboss_admin::resource::remote_destination_outbound_socket_binding (
  $server,
  $fixed_source_port              = undef,
  $host                           = undef,
  $port                           = undef,
  $source_interface               = undef,
  $source_port                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $source_port != undef and !is_integer($source_port) { 
      fail('The attribute source_port is not an integer') 
    }
  

    $raw_options = { 
      'fixed-source-port'            => $fixed_source_port,
      'host'                         => $host,
      'port'                         => $port,
      'source-interface'             => $source_interface,
      'source-port'                  => $source_port,
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
