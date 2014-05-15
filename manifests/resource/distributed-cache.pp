# == Defines jboss_admin::distributed-cache
#
# A distributed cache
#
# === Parameters
#
# [*virtual_nodes*]
#   Controls the number of virtual nodes per "real" node. If numVirtualNodes is 1, then virtual nodes are disabled. The topology aware consistent hash must be used if you wish to take advantage of virtual nodes. A default of 1 is used.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*async_marshalling*]
#   If enabled, this will cause marshalling of entries to be performed asynchronously.
#
# [*owners*]
#   Number of cluster-wide replicas for each cache entry.
#
# [*l1_lifespan*]
#   Maximum lifespan of an entry placed in the L1 cache. This element configures the L1 cache behavior in 'distributed' caches instances. In any other cache modes, this element is ignored.
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
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*remote_timeout*]
#   In SYNC mode, the timeout (in ms) used to wait for an acknowledgment when making a remote call, after which the call is aborted and an exception is thrown.
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
#
define jboss_admin::resource::distributed-cache (
  $server,
  $virtual_nodes                  = undef,
  $start                          = undef,
  $batching                       = undef,
  $async_marshalling              = undef,
  $owners                         = undef,
  $l1_lifespan                    = undef,
  $indexing                       = undef,
  $queue_size                     = undef,
  $queue_flush_interval           = undef,
  $mode                           = undef,
  $remote_timeout                 = undef,
  $jndi_name                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $virtual_nodes != undef and !is_integer($virtual_nodes) { 
      fail('The attribute virtual_nodes is not an integer') 
    }
    if $owners != undef and !is_integer($owners) { 
      fail('The attribute owners is not an integer') 
    }
    if $queue_size != undef and !is_integer($queue_size) { 
      fail('The attribute queue_size is not an integer') 
    }
  

    $raw_options = { 
      'virtual-nodes'                => $virtual_nodes,
      'start'                        => $start,
      'batching'                     => $batching,
      'async-marshalling'            => $async_marshalling,
      'owners'                       => $owners,
      'l1-lifespan'                  => $l1_lifespan,
      'indexing'                     => $indexing,
      'queue-size'                   => $queue_size,
      'queue-flush-interval'         => $queue_flush_interval,
      'mode'                         => $mode,
      'remote-timeout'               => $remote_timeout,
      'jndi-name'                    => $jndi_name,
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
