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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }

    $raw_options = {
      'enabled'                      => $enabled,
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
