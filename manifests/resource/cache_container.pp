# == Defines jboss_admin::cache_container
#
# The configuration of an infinispan cache container
#
# === Parameters
#
# [*aliases*]
#   The list of aliases for this cache container
#
# [*default_cache*]
#   The default infinispan cache
#
# [*eviction_executor*]
#   The scheduled executor used for eviction
#
# [*jndi_name*]
#   The jndi name to which to bind this cache container
#
# [*listener_executor*]
#   The executor used for the replication queue
#
# [*replication_queue_executor*]
#   The executor used for asynchronous cache operations
#
# [*start*]
#   The cache container start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
#
define jboss_admin::resource::cache_container (
  $server,
  $aliases                        = undef,
  $default_cache                  = undef,
  $eviction_executor              = undef,
  $jndi_name                      = undef,
  $listener_executor              = undef,
  $replication_queue_executor     = undef,
  $start                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'aliases'                      => $aliases,
      'default-cache'                => $default_cache,
      'eviction-executor'            => $eviction_executor,
      'jndi-name'                    => $jndi_name,
      'listener-executor'            => $listener_executor,
      'replication-queue-executor'   => $replication_queue_executor,
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
