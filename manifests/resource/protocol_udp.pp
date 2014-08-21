# == Defines jboss_admin::protocol_udp
#
# Configuration to append to syslog over udp/ip.
#
# === Parameters
#
# [*host*]
#   The host of the syslog server for the udp requests.
#
# [*port*]
#   The port of the syslog server for the udp requests.
#
#
define jboss_admin::resource::protocol_udp (
  $server,
  $host                           = undef,
  $port                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $host != undef and !is_string($host) { 
      fail('The attribute host is not a string') 
    }
    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
  

    $raw_options = { 
      'host'                         => $host,
      'port'                         => $port,
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
