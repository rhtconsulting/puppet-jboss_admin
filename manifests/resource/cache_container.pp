# == Defines jboss_admin::cache_container
#
# The configuration of an infinispan cache container
#
# === Parameters
#
# [*aliases*]
#   The list of aliases for this cache container
#
# [*listener_executor*]
#   The executor used for the replication queue
#
# [*jndi_name*]
#   The jndi name to which to bind this cache container
#
# [*start*]
#   The cache container start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*eviction_executor*]
#   The scheduled executor used for eviction
#
# [*replication_queue_executor*]
#   The executor used for asynchronous cache operations
#
# [*default_cache*]
#   The default infinispan cache
#
#
define jboss_admin::resource::cache_container (
  $server,
  $aliases                        = undef,
  $listener_executor              = undef,
  $jndi_name                      = undef,
  $start                          = undef,
  $eviction_executor              = undef,
  $replication_queue_executor     = undef,
  $default_cache                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'aliases'                      => $aliases,
      'listener-executor'            => $listener_executor,
      'jndi-name'                    => $jndi_name,
      'start'                        => $start,
      'eviction-executor'            => $eviction_executor,
      'replication-queue-executor'   => $replication_queue_executor,
      'default-cache'                => $default_cache,
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
