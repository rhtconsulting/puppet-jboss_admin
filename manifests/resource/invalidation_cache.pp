# == Defines jboss_admin::invalidation_cache
#
# An invalidation cache
#
# === Parameters
#
# [*queue_flush_interval*]
#   In ASYNC mode, this attribute controls how often the asynchronous thread used to flush the replication queue runs. This should be a positive integer which represents thread wakeup time in milliseconds.
#
# [*remote_timeout*]
#   In SYNC mode, the timeout (in ms) used to wait for an acknowledgment when making a remote call, after which the call is aborted and an exception is thrown.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*async_marshalling*]
#   If enabled, this will cause marshalling of entries to be performed asynchronously.
#
# [*indexing*]
#   If enabled, entries will be indexed when they are added to the cache. Indexes will be updated as entries change or are removed.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*queue_size*]
#   In ASYNC mode, this attribute can be used to trigger flushing of the queue when it reaches a specific threshold.
#
#
define jboss_admin::resource::invalidation_cache (
  $server,
  $queue_flush_interval           = undef,
  $remote_timeout                 = undef,
  $start                          = undef,
  $jndi_name                      = undef,
  $batching                       = undef,
  $async_marshalling              = undef,
  $indexing                       = undef,
  $mode                           = undef,
  $queue_size                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_size != undef and !is_integer($queue_size) { 
      fail('The attribute queue_size is not an integer') 
    }
  

    $raw_options = { 
      'queue-flush-interval'         => $queue_flush_interval,
      'remote-timeout'               => $remote_timeout,
      'start'                        => $start,
      'jndi-name'                    => $jndi_name,
      'batching'                     => $batching,
      'async-marshalling'            => $async_marshalling,
      'indexing'                     => $indexing,
      'mode'                         => $mode,
      'queue-size'                   => $queue_size,
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
