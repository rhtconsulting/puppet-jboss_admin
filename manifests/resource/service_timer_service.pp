# == Defines jboss_admin::service_timer_service
#
# The EJB timer service
#
# === Parameters
#
# [*default_data_store*]
#   The default data store used for persistent timers
#
# [*thread_pool_name*]
#   The name of the thread pool used to run timer service invocations
#
#
define jboss_admin::resource::service_timer_service (
  $server,
  $default_data_store             = undef,
  $thread_pool_name               = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'default-data-store'           => $default_data_store,
      'thread-pool-name'             => $thread_pool_name,
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
