# == Defines jboss_admin::unbounded-queue-thread-pool
#
# A thread pool executor with an unbounded queue.  Such a thread pool has a core size and a queue with no upper bound.  When a task is submitted, if the number of running threads is less than the core size, a new thread is created.  Otherwise, the task is placed in queue.  If too many tasks are allowed to be submitted to this type of executor, an out of memory condition may occur.
#
# === Parameters
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
# [*max_threads*]
#   The maximum thread pool size.
#
#
define jboss_admin::unbounded-queue-thread-pool (
  $server,
  $keepalive_time                 = undef,
  $thread_factory                 = undef,
  $name                           = undef,
  $max_threads                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_threads != undef && !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
  

    $raw_options = { 
      'keepalive-time'               => $keepalive_time,
      'thread-factory'               => $thread_factory,
      'name'                         => $name,
      'max-threads'                  => $max_threads,
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
