# == Defines jboss_admin::service_timer-service
#
# The EJB timer service
#
# === Parameters
#
# [*relative_to*]
#   The relative path that is used to resolve the timer data store location
#
# [*path*]
#   The directory to store persistent timer information in
#
# [*thread_pool_name*]
#   The name of the thread pool used to run timer service invocations
#
#
define jboss_admin::resource::service_timer-service (
  $server,
  $relative_to                    = undef,
  $path                           = undef,
  $thread_pool_name               = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'path'                         => $path,
      'thread-pool-name'             => $thread_pool_name,
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
