# == Defines jboss_admin::local_outbound_connection
#
# Remoting outbound connection with a implicit local:// URI scheme.
#
# === Parameters
#
# [*outbound_socket_binding_ref*]
#   Name of the outbound-socket-binding which will be used to determine the destination address and port for the connection.
#
#
define jboss_admin::resource::local_outbound_connection (
  $server,
  $outbound_socket_binding_ref    = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $outbound_socket_binding_ref != undef and !is_string($outbound_socket_binding_ref) { 
      fail('The attribute outbound_socket_binding_ref is not a string') 
    }
  

    $raw_options = { 
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
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
