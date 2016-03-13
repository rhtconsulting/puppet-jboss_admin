# == Defines jboss_admin::log_store
#
# Representation of the transaction logging storage mechanism.
#
# === Parameters
#
# [*expose_all_logs*]
#   Whether to expose all logs like orphans etc. By default only a subset of transaction logs is exposed.
#
# [*type*]
#   Specifies the implementation type of the logging store.
#
#
define jboss_admin::resource::log_store (
  $server,
  $expose_all_logs                = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $expose_all_logs != undef and $expose_all_logs != undefined {
      validate_bool($expose_all_logs)
    }

    $raw_options = {
      'expose-all-logs'              => $expose_all_logs,
      'type'                         => $type,
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
