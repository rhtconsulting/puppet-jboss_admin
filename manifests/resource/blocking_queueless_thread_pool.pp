# == Defines jboss_admin::blocking_queueless_thread_pool
#
# A thread pool executor with no queue where threads submittings tasks may block.  When a task is submitted, if the number of running threads is less than the maximum size, a new thread is created.  Otherwise, the caller blocks until another thread completes its task and accepts the new one.
#
# === Parameters
#
# [*keepalive_time*]
#   Used to specify the amount of time that pool threads should be kept running when idle; if not specified, threads will run until the executor is shut down.
#
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
# [*max_threads*]
#   The maximum thread pool size.
#
# [*resource_name*]
#   The name of the thread pool.
#
#
define jboss_admin::resource::blocking_queueless_thread_pool (
  $server,
  $keepalive_time                 = undef,
  $thread_factory                 = undef,
  $max_threads                    = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
  

    $raw_options = { 
      'keepalive-time'               => $keepalive_time,
      'thread-factory'               => $thread_factory,
      'max-threads'                  => $max_threads,
      'name'                         => $resource_name,
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