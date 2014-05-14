# == Defines jboss_admin::remote-destination-outbound-socket-binding
#
# Configuration information for a, remote destination, outbound socket binding.
#
# === Parameters
#
# [*port*]
#   The port number of the remote destination to which the outbound socket should connect.
#
# [*fixed_source_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other outbound sockets in the socket group.
#
# [*source_interface*]
#   The name of the interface which will be used for the source address of the outbound socket.
#
# [*host*]
#   The host name or the IP address of the remote destination to which this outbound socket will connect.
#
# [*source_port*]
#   The port number which will be used as the source port of the outbound socket.
#
#
define jboss_admin::remote-destination-outbound-socket-binding (
  $server,
  $port                           = undef,
  $fixed_source_port              = undef,
  $source_interface               = undef,
  $host                           = undef,
  $source_port                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $port != undef && !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
    if $source_port != undef && !is_integer($source_port) { 
      fail('The attribute source_port is not an integer') 
    }
  

    $raw_options = { 
      'port'                         => $port,
      'fixed-source-port'            => $fixed_source_port,
      'source-interface'             => $source_interface,
      'host'                         => $host,
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
