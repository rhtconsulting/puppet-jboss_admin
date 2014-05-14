# == Defines jboss_admin::replicated-cache
#
# A replicated cache
#
# === Parameters
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*async_marshalling*]
#   If enabled, this will cause marshalling of entries to be performed asynchronously.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*indexing*]
#   If enabled, entries will be indexed when they are added to the cache. Indexes will be updated as entries change or are removed.
#
# [*queue_size*]
#   In ASYNC mode, this attribute can be used to trigger flushing of the queue when it reaches a specific threshold.
#
# [*queue_flush_interval*]
#   In ASYNC mode, this attribute controls how often the asynchronous thread used to flush the replication queue runs. This should be a positive integer which represents thread wakeup time in milliseconds.
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
# [*remote_timeout*]
#   In SYNC mode, the timeout (in ms) used to wait for an acknowledgment when making a remote call, after which the call is aborted and an exception is thrown.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
#
define jboss_admin::replicated-cache (
  $server,
  $batching                       = undef,
  $async_marshalling              = undef,
  $start                          = undef,
  $indexing                       = undef,
  $queue_size                     = undef,
  $queue_flush_interval           = undef,
  $jndi_name                      = undef,
  $remote_timeout                 = undef,
  $mode                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_size != undef && !is_integer($queue_size) { 
      fail('The attribute queue_size is not an integer') 
    }
  

    $raw_options = { 
      'batching'                     => $batching,
      'async-marshalling'            => $async_marshalling,
      'start'                        => $start,
      'indexing'                     => $indexing,
      'queue-size'                   => $queue_size,
      'queue-flush-interval'         => $queue_flush_interval,
      'jndi-name'                    => $jndi_name,
      'remote-timeout'               => $remote_timeout,
      'mode'                         => $mode,
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
