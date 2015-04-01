# == Defines jboss_admin::handler
#
# Endpoint handler
#
# === Parameters
#
# [*class*]
#   Handler class
#
#
define jboss_admin::resource::handler (
  $server,
  $class                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'class'                        => $class,
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
