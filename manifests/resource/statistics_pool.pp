# == Defines jboss_admin::statistics_pool
#
# Runtime statistics provided by the resource adapter.
#
# === Parameters
#
# [*statistics_enabled*]
#   define if runtime statistics is enabled or not
#
#
define jboss_admin::resource::statistics_pool (
  $server,
  $statistics_enabled             = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $statistics_enabled != undef and $statistics_enabled != undefined {
      validate_bool($statistics_enabled)
    }

    $raw_options = {
      'statistics-enabled'           => $statistics_enabled,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
