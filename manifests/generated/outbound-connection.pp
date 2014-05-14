# == Defines jboss_admin::outbound-connection
#
# Remoting outbound connection.
#
# === Parameters
#
# [*uri*]
#   The connection URI for the outbound connection.
#
#
define jboss_admin::outbound-connection (
  $server,
  $uri                            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'uri'                          => $uri,
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
