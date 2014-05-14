# == Defines jboss_admin::local-outbound-connection
#
# Remoting outbound connection with a implicit local:// URI scheme.
#
# === Parameters
#
# [*outbound_socket_binding_ref*]
#   Name of the outbound-socket-binding which will be used to determine the destination address and port for the connection.
#
#
define jboss_admin::local-outbound-connection (
  $server,
  $outbound_socket_binding_ref    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'outbound-socket-binding-ref'  => $outbound_socket_binding_ref,
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
