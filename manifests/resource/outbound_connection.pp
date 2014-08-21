# == Defines jboss_admin::outbound_connection
#
# Remoting outbound connection.
#
# === Parameters
#
# [*uri*]
#   The connection URI for the outbound connection.
#
#
define jboss_admin::resource::outbound_connection (
  $server,
  $uri                            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $uri != undef and !is_string($uri) { 
      fail('The attribute uri is not a string') 
    }
  

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
