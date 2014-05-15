# == Defines jboss_admin::remote-destination-outbound-socket-binding
#
# Configuration information for a, remote destination, outbound socket binding.
#
# === Parameters
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
# [*fixed_source_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other outbound sockets in the socket group.
#
# [*host*]
#   The host name or the IP address of the remote destination to which this outbound socket will connect.
#
#
define jboss_admin::resource::remote-destination-outbound-socket-binding (
  $server,
  $port                           = undef,
  $source_interface               = undef,
  $source_port                    = undef,
  $fixed_source_port              = undef,
  $host                           = undef,
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
      'port'                         => $port,
      'source-interface'             => $source_interface,
      'source-port'                  => $source_port,
      'fixed-source-port'            => $fixed_source_port,
      'host'                         => $host,
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
