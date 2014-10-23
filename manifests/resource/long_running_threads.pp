# == Defines jboss_admin::long_running_threads
#
# A thread pool executor with a bounded queue where threads submittings tasks will not block. Such a thread pool has a core and maximum size and a specified queue length.  When a task is submitted, if the number of running threads is less than the core size, a new thread is created.  Otherwise, if there is room in the queue, the task is enqueued. Otherwise, if the number of running threads is less than the maximum size, a new thread is created. Otherwise, the task is handed off to the designated handoff executor, if one is specified.  Otherwise, the task is discarded.
#
# === Parameters
#
# [*allow_core_timeout*]
#   Whether core threads may time out.
#
# [*core_threads*]
#   The core thread pool size which is smaller than the maximum pool size. If undefined, the core thread pool size is the same as the maximum thread pool size.
#
# [*handoff_executor*]
#   An executor to delegate tasks to in the event that a task cannot be accepted. If not specified, tasks that cannot be accepted will be silently discarded.
#
# [*keepalive_time*]
#   Used to specify the amount of time that pool threads should be kept running when idle; if not specified, threads will run until the executor is shut down.
#
# [*max_threads*]
#   The maximum thread pool size.
#
# [*resource_name*]
#   The name of the thread pool.
#
# [*queue_length*]
#   The queue length.
#
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
#
define jboss_admin::resource::long_running_threads (
  $server,
  $allow_core_timeout             = undef,
  $core_threads                   = undef,
  $handoff_executor               = undef,
  $keepalive_time                 = undef,
  $max_threads                    = undef,
  $resource_name                  = undef,
  $queue_length                   = undef,
  $thread_factory                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $allow_core_timeout != undef { 
      validate_bool($allow_core_timeout)
    }
    if $core_threads != undef and !is_integer($core_threads) { 
      fail('The attribute core_threads is not an integer') 
    }
    if $handoff_executor != undef and !is_string($handoff_executor) { 
      fail('The attribute handoff_executor is not a string') 
    }
    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
    if $queue_length != undef and !is_integer($queue_length) { 
      fail('The attribute queue_length is not an integer') 
    }
    if $thread_factory != undef and !is_string($thread_factory) { 
      fail('The attribute thread_factory is not a string') 
    }
  

    $raw_options = { 
      'allow-core-timeout'           => $allow_core_timeout,
      'core-threads'                 => $core_threads,
      'handoff-executor'             => $handoff_executor,
      'keepalive-time'               => $keepalive_time,
      'max-threads'                  => $max_threads,
      'name'                         => $resource_name,
      'queue-length'                 => $queue_length,
      'thread-factory'               => $thread_factory,
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
