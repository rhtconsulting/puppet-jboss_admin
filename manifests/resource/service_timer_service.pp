# == Defines jboss_admin::service_timer_service
#
# The EJB timer service
#
# === Parameters
#
# [*path*]
#   The directory to store persistent timer information in
#
# [*relative_to*]
#   The relative path that is used to resolve the timer data store location
#
# [*thread_pool_name*]
#   The name of the thread pool used to run timer service invocations
#
#
define jboss_admin::resource::service_timer_service (
  $server,
  $path                           = undef,
  $relative_to                    = undef,
  $thread_pool_name               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = {
      'path'                         => $path,
      'relative-to'                  => $relative_to,
      'thread-pool-name'             => $thread_pool_name,
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
