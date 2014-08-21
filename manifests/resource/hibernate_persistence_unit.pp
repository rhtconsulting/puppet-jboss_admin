# == Defines jboss_admin::hibernate_persistence_unit
#
# Runtime information about Hibernate use in the deployment.
#
# === Parameters
#
# [*enabled*]
#   Determine if statistics are enabled.
#
#
define jboss_admin::resource::hibernate_persistence_unit (
  $server,
  $enabled                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $enabled != undef and !is_bool($enabled) { 
      fail('The attribute enabled is not a boolean') 
    }
  

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
