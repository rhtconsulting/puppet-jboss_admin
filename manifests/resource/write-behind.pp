# == Defines jboss_admin::write-behind
#
# Configures a cache store as write-behind instead of write-through.
#
# === Parameters
#
# [*flush_lock_timeout*]
#   Timeout to acquire the lock which guards the state to be flushed to the cache store periodically.
#
# [*modification_queue_size*]
#   Maximum number of entries in the asynchronous queue. When the queue is full, the store becomes write-through until it can accept new entries.
#
# [*thread_pool_size*]
#   Size of the thread pool whose threads are responsible for applying the modifications to the cache store.
#
# [*shutdown_timeout*]
#   Timeout in milliseconds to stop the cache store.
#
#
define jboss_admin::resource::write-behind (
  $server,
  $flush_lock_timeout             = undef,
  $modification_queue_size        = undef,
  $thread_pool_size               = undef,
  $shutdown_timeout               = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $modification_queue_size != undef and !is_integer($modification_queue_size) { 
      fail('The attribute modification_queue_size is not an integer') 
    }
    if $thread_pool_size != undef and !is_integer($thread_pool_size) { 
      fail('The attribute thread_pool_size is not an integer') 
    }
  

    $raw_options = { 
      'flush-lock-timeout'           => $flush_lock_timeout,
      'modification-queue-size'      => $modification_queue_size,
      'thread-pool-size'             => $thread_pool_size,
      'shutdown-timeout'             => $shutdown_timeout,
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
