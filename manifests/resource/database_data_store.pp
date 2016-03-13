# == Defines jboss_admin::database_data_store
#
# An database based store for persistent EJB timers.
#
# === Parameters
#
# [*database*]
#   The type of database that is in use. SQL can be customised per database type.
#
# [*datasource_jndi_name*]
#   The datasource that is used to persist the timers
#
# [*partition*]
#   The partition name. This should be set to a different value for every node that is sharing a database to prevent the same timer being loaded by multiple noded.
#
#
define jboss_admin::resource::database_data_store (
  $server,
  $database                       = undef,
  $datasource_jndi_name           = undef,
  $partition                      = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'database'                     => $database,
      'datasource-jndi-name'         => $datasource_jndi_name,
      'partition'                    => $partition,
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
