# == Defines jboss_admin::protocol
#
# The configuration of a protocol within a protocol stack.
#
# === Parameters
#
# [*socket_binding*]
#   The socket binding specification for this protocol layer, used to specify IP interfaces and ports for communication.
#
# [*type*]
#   The implementation class for a protocol, which determines protocol functionality.
#
#
define jboss_admin::resource::protocol (
  $server,
  $socket_binding                 = undef,
  $type                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'socket-binding'               => $socket_binding,
      'type'                         => $type,
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
