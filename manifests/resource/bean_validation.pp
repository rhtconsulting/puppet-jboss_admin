# == Defines jboss_admin::bean_validation
#
# Bean validation (JSR-303) for resource adapters
#
# === Parameters
#
# [*enabled*]
#   Specify whether bean validation is enabled
#
#
define jboss_admin::resource::bean_validation (
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
