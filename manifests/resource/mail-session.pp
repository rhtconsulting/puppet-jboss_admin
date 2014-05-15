# == Defines jboss_admin::mail-session
#
# Mail session definition
#
# === Parameters
#
# [*from*]
#   From address that is used as default from, if not set when sending
#
# [*jndi_name*]
#   JNDI name to where mail session should be bound
#
# [*debug*]
#   Enables javamail debugging
#
#
define jboss_admin::resource::mail-session (
  $server,
  $from                           = undef,
  $jndi_name                      = undef,
  $debug                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'from'                         => $from,
      'jndi-name'                    => $jndi_name,
      'debug'                        => $debug,
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
