# == Defines jboss_admin::distributed_cache
#
# A distributed cache
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
# [*indexing_properties*]
#   Properties to control indexing behaviour
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
# [*l1_lifespan*]
#   Maximum lifespan of an entry placed in the L1 cache. This element configures the L1 cache behavior in 'distributed' caches instances. In any other cache modes, this element is ignored.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*module*]
#   The module whose class loader should be used when building this cache's configuration.
#
# [*owners*]
#   Number of cluster-wide replicas for each cache entry.
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
# [*segments*]
#   Controls the number of hash space segments which is the granularity for key distribution in the cluster. Value must be strictly positive.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*statistics_enabled*]
#   If enabled, statistics will be collected for this cache
#
# [*virtual_nodes*]
#   Deprecated. Has no effect.
#
#
define jboss_admin::resource::distributed_cache (
  $server,
  $async_marshalling              = undef,
  $batching                       = undef,
  $indexing                       = undef,
  $indexing_properties            = undef,
  $jndi_name                      = undef,
  $l1_lifespan                    = undef,
  $mode                           = undef,
  $module                         = undef,
  $owners                         = undef,
  $queue_flush_interval           = undef,
  $queue_size                     = undef,
  $remote_timeout                 = undef,
  $segments                       = undef,
  $start                          = undef,
  $statistics_enabled             = undef,
  $virtual_nodes                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $async_marshalling != undef and $async_marshalling != undefined {
      validate_bool($async_marshalling)
    }
    if $batching != undef and $batching != undefined {
      validate_bool($batching)
    }
    if $indexing != undef and $indexing != undefined and !($indexing in ['NONE','LOCAL','ALL']) {
      fail('The attribute indexing is not an allowed value: "NONE","LOCAL","ALL"')
    }
    if $l1_lifespan != undef and $l1_lifespan != undefined and !is_integer($l1_lifespan) {
      fail('The attribute l1_lifespan is not an integer')
    }
    if $mode != undef and $mode != undefined and !($mode in ['SYNC','ASYNC']) {
      fail('The attribute mode is not an allowed value: "SYNC","ASYNC"')
    }
    if $owners != undef and $owners != undefined and !is_integer($owners) {
      fail('The attribute owners is not an integer')
    }
    if $queue_flush_interval != undef and $queue_flush_interval != undefined and !is_integer($queue_flush_interval) {
      fail('The attribute queue_flush_interval is not an integer')
    }
    if $queue_size != undef and $queue_size != undefined and !is_integer($queue_size) {
      fail('The attribute queue_size is not an integer')
    }
    if $remote_timeout != undef and $remote_timeout != undefined and !is_integer($remote_timeout) {
      fail('The attribute remote_timeout is not an integer')
    }
    if $segments != undef and $segments != undefined and !is_integer($segments) {
      fail('The attribute segments is not an integer')
    }
    if $start != undef and $start != undefined and !($start in ['EAGER','LAZY']) {
      fail('The attribute start is not an allowed value: "EAGER","LAZY"')
    }
    if $statistics_enabled != undef and $statistics_enabled != undefined {
      validate_bool($statistics_enabled)
    }
    if $virtual_nodes != undef and $virtual_nodes != undefined and !is_integer($virtual_nodes) {
      fail('The attribute virtual_nodes is not an integer')
    }

    $raw_options = {
      'async-marshalling'            => $async_marshalling,
      'batching'                     => $batching,
      'indexing'                     => $indexing,
      'indexing-properties'          => $indexing_properties,
      'jndi-name'                    => $jndi_name,
      'l1-lifespan'                  => $l1_lifespan,
      'mode'                         => $mode,
      'module'                       => $module,
      'owners'                       => $owners,
      'queue-flush-interval'         => $queue_flush_interval,
      'queue-size'                   => $queue_size,
      'remote-timeout'               => $remote_timeout,
      'segments'                     => $segments,
      'start'                        => $start,
      'statistics-enabled'           => $statistics_enabled,
      'virtual-nodes'                => $virtual_nodes,
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
