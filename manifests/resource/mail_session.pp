# == Defines jboss_admin::mail_session
#
# Mail session definition
#
# === Parameters
#
# [*jndi_name*]
#   JNDI name to where mail session should be bound
#
# [*from*]
#   From address that is used as default from, if not set when sending
#
# [*debug*]
#   Enables javamail debugging
#
#
define jboss_admin::resource::mail_session (
  $server,
  $jndi_name                      = undef,
  $from                           = undef,
  $debug                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'jndi-name'                    => $jndi_name,
      'from'                         => $from,
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
