# == Defines jboss_admin::hibernate-persistence-unit
#
# Runtime information about Hibernate use in the deployment.
#
# === Parameters
#
# [*enabled*]
#   Determine if statistics are enabled.
#
#
define jboss_admin::resource::hibernate-persistence-unit (
  $server,
  $enabled                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'enabled'                      => $enabled,
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
