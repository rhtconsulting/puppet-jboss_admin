# == Defines jboss_admin::mail-session
#
# Mail session definition
#
# === Parameters
#
# [*jndi_name*]
#   JNDI name to where mail session should be bound
#
# [*debug*]
#   Enables javamail debugging
#
# [*from*]
#   From address that is used as default from, if not set when sending
#
#
define jboss_admin::mail-session (
  $server,
  $jndi_name                      = undef,
  $debug                          = undef,
  $from                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'jndi-name'                    => $jndi_name,
      'debug'                        => $debug,
      'from'                         => $from,
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
