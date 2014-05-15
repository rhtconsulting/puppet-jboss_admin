# == Defines jboss_admin::cache-container
#
# The configuration of an infinispan cache container
#
# === Parameters
#
# [*replication_queue_executor*]
#   The executor used for asynchronous cache operations
#
# [*default_cache*]
#   The default infinispan cache
#
# [*start*]
#   The cache container start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
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
# [*eviction_executor*]
#   The scheduled executor used for eviction
#
#
define jboss_admin::resource::cache-container (
  $server,
  $replication_queue_executor     = undef,
  $default_cache                  = undef,
  $start                          = undef,
  $aliases                        = undef,
  $listener_executor              = undef,
  $jndi_name                      = undef,
  $eviction_executor              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'replication-queue-executor'   => $replication_queue_executor,
      'default-cache'                => $default_cache,
      'start'                        => $start,
      'aliases'                      => $aliases,
      'listener-executor'            => $listener_executor,
      'jndi-name'                    => $jndi_name,
      'eviction-executor'            => $eviction_executor,
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
