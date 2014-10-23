# == Defines jboss_admin::protocol_tls
#
# Configuration to append to syslog over tls over tcp/ip.
#
# === Parameters
#
# [*host*]
#   The host of the syslog server for the tls over tcp requests.
#
# [*message_transfer*]
#   The message transfer setting as described in section 3.4 of RFC-6587. This can either be OCTET_COUNTING as described in section 3.4.1 of RFC-6587, or NON_TRANSPARENT_FRAMING as described in section 3.4.1 of RFC-6587. See your syslog provider's documentation for what is supported.
#
# [*port*]
#   The port of the syslog server for the tls over tcp requests.
#
#
define jboss_admin::resource::protocol_tls (
  $server,
  $host                           = undef,
  $message_transfer               = undef,
  $port                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $host != undef and !is_string($host) { 
      fail('The attribute host is not a string') 
    }
    if $message_transfer != undef and !is_string($message_transfer) { 
      fail('The attribute message_transfer is not a string') 
    }
    if $port != undef and !is_integer($port) { 
      fail('The attribute port is not an integer') 
    }
  

    $raw_options = { 
      'host'                         => $host,
      'message-transfer'             => $message_transfer,
      'port'                         => $port,
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
