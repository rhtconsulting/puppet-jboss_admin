# == Defines jboss_admin::queueless_thread_pool
#
# A thread pool executor with no queue where threads submittings tasks will not block.  When a task is submitted, if the number of running threads is less than the maximum size, a new thread is created.  Otherwise, the task is handed off to the designated handoff executor, if one is specified.  Otherwise, the task is discarded.
#
# === Parameters
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
# [*thread_factory*]
#   Specifies the name of a specific thread factory to use to create worker threads. If not defined an appropriate default thread factory will be used.
#
#
define jboss_admin::resource::queueless_thread_pool (
  $server,
  $handoff_executor               = undef,
  $keepalive_time                 = undef,
  $max_threads                    = undef,
  $resource_name                  = undef,
  $thread_factory                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $handoff_executor != undef and !is_string($handoff_executor) { 
      fail('The attribute handoff_executor is not a string') 
    }
    if $max_threads != undef and !is_integer($max_threads) { 
      fail('The attribute max_threads is not an integer') 
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
    if $thread_factory != undef and !is_string($thread_factory) { 
      fail('The attribute thread_factory is not a string') 
    }
  

    $raw_options = { 
      'handoff-executor'             => $handoff_executor,
      'keepalive-time'               => $keepalive_time,
      'max-threads'                  => $max_threads,
      'name'                         => $resource_name,
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
