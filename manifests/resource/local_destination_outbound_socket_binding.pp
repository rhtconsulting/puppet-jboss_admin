# == Defines jboss_admin::local_destination_outbound_socket_binding
#
# Configuration information for a local destination outbound socket binding.
#
# === Parameters
#
# [*fixed_source_port*]
#   Whether the port value should remain fixed even if numeric offsets are applied to the other outbound sockets in the socket group.
#
# [*socket_binding_ref*]
#   The name of the local socket-binding which will be used to determine the port to which this outbound socket connects.
#
# [*source_interface*]
#   The name of the interface which will be used for the source address of the outbound socket.
#
# [*source_port*]
#   The port number which will be used as the source port of the outbound socket.
#
#
define jboss_admin::resource::local_destination_outbound_socket_binding (
  $server,
  $fixed_source_port              = undef,
  $socket_binding_ref             = undef,
  $source_interface               = undef,
  $source_port                    = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $fixed_source_port != undef and $fixed_source_port != undefined {
      validate_bool($fixed_source_port)
    }
    if $source_port != undef and $source_port != undefined and !is_integer($source_port) {
      fail('The attribute source_port is not an integer')
    }
  

    $raw_options = {
      'fixed-source-port'            => $fixed_source_port,
      'socket-binding-ref'           => $socket_binding_ref,
      'source-interface'             => $source_interface,
      'source-port'                  => $source_port,
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
