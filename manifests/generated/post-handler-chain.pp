# == Defines jboss_admin::post-handler-chain
#
# Endpoint configuration POST handler chain
#
# === Parameters
#
# [*protocol_bindings*]
#   Protocol binding
#
#
define jboss_admin::post-handler-chain (
  $server,
  $protocol_bindings              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'protocol-bindings'            => $protocol_bindings,
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
