# == Defines jboss_admin::write_behind
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
# [*shutdown_timeout*]
#   Timeout in milliseconds to stop the cache store.
#
# [*thread_pool_size*]
#   Size of the thread pool whose threads are responsible for applying the modifications to the cache store.
#
#
define jboss_admin::resource::write_behind (
  $server,
  $flush_lock_timeout             = undef,
  $modification_queue_size        = undef,
  $shutdown_timeout               = undef,
  $thread_pool_size               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $flush_lock_timeout != undef and $flush_lock_timeout != undefined and !is_integer($flush_lock_timeout) {
      fail('The attribute flush_lock_timeout is not an integer')
    }
    if $modification_queue_size != undef and $modification_queue_size != undefined and !is_integer($modification_queue_size) {
      fail('The attribute modification_queue_size is not an integer')
    }
    if $shutdown_timeout != undef and $shutdown_timeout != undefined and !is_integer($shutdown_timeout) {
      fail('The attribute shutdown_timeout is not an integer')
    }
    if $thread_pool_size != undef and $thread_pool_size != undefined and !is_integer($thread_pool_size) {
      fail('The attribute thread_pool_size is not an integer')
    }
  

    $raw_options = {
      'flush-lock-timeout'           => $flush_lock_timeout,
      'modification-queue-size'      => $modification_queue_size,
      'shutdown-timeout'             => $shutdown_timeout,
      'thread-pool-size'             => $thread_pool_size,
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
