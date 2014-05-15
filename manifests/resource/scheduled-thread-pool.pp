# == Defines jboss_admin::scheduled-thread-pool
#
# A scheduled thread pool executor.
#
# === Parameters
#
# [*max_threads*]
#   The maximum thread pool size.
#
# [*keepalive_time*]
#   Used to specify the amount of time that pool threads should be kept running when idle; if not specified, threads will run until the executor is shut down.
#
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
# [*name*]
#   The name of the thread pool.
#
#
define jboss_admin::resource::scheduled-thread-pool (
  $server,
  $max_threads                    = undef,
  $keepalive_time                 = undef,
  $thread_factory                 = undef,
  $name                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
  

    $raw_options = { 
      'max-threads'                  => $max_threads,
      'keepalive-time'               => $keepalive_time,
      'thread-factory'               => $thread_factory,
      'name'                         => $name,
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
