# == Defines jboss_admin::invalidation_cache
#
# An invalidation cache
#
# === Parameters
#
# [*async_marshalling*]
#   If enabled, this will cause marshalling of entries to be performed asynchronously.
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*indexing*]
#   If enabled, entries will be indexed when they are added to the cache. Indexes will be updated as entries change or are removed.
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*queue_flush_interval*]
#   In ASYNC mode, this attribute controls how often the asynchronous thread used to flush the replication queue runs. This should be a positive integer which represents thread wakeup time in milliseconds.
#
# [*queue_size*]
#   In ASYNC mode, this attribute can be used to trigger flushing of the queue when it reaches a specific threshold.
#
# [*remote_timeout*]
#   In SYNC mode, the timeout (in ms) used to wait for an acknowledgment when making a remote call, after which the call is aborted and an exception is thrown.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
#
define jboss_admin::resource::invalidation_cache (
  $server,
  $async_marshalling              = undef,
  $batching                       = undef,
  $indexing                       = undef,
  $jndi_name                      = undef,
  $mode                           = undef,
  $queue_flush_interval           = undef,
  $queue_size                     = undef,
  $remote_timeout                 = undef,
  $start                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_size != undef and !is_integer($queue_size) { 
      fail('The attribute queue_size is not an integer') 
    }
  

    $raw_options = { 
      'async-marshalling'            => $async_marshalling,
      'batching'                     => $batching,
      'indexing'                     => $indexing,
      'jndi-name'                    => $jndi_name,
      'mode'                         => $mode,
      'queue-flush-interval'         => $queue_flush_interval,
      'queue-size'                   => $queue_size,
      'remote-timeout'               => $remote_timeout,
      'start'                        => $start,
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
