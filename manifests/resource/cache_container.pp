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
#   The jndi-name to which to bind this cache instance.
#
# [*listener_executor*]
#   The executor used for the replication queue
#
# [*module*]
#   The module whose class loader should be used when building this cache's configuration.
#
# [*replication_queue_executor*]
#   The executor used for asynchronous cache operations
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*statistics_enabled*]
#   If enabled, statistics will be collected for this cache
#
#
define jboss_admin::resource::cache_container (
  $server,
  $aliases                        = undef,
  $default_cache                  = undef,
  $eviction_executor              = undef,
  $jndi_name                      = undef,
  $listener_executor              = undef,
  $module                         = undef,
  $replication_queue_executor     = undef,
  $start                          = undef,
  $statistics_enabled             = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $aliases != undef and !is_array($aliases) { 
      fail('The attribute aliases is not an array') 
    }
    if $default_cache != undef and !is_string($default_cache) { 
      fail('The attribute default_cache is not a string') 
    }
    if $eviction_executor != undef and !is_string($eviction_executor) { 
      fail('The attribute eviction_executor is not a string') 
    }
    if $jndi_name != undef and !is_string($jndi_name) { 
      fail('The attribute jndi_name is not a string') 
    }
    if $listener_executor != undef and !is_string($listener_executor) { 
      fail('The attribute listener_executor is not a string') 
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
    if $replication_queue_executor != undef and !is_string($replication_queue_executor) { 
      fail('The attribute replication_queue_executor is not a string') 
    }
    if $start != undef and !is_string($start) { 
      fail('The attribute start is not a string') 
    }
    if $start != undef and !($start in ['EAGER','LAZY']) {
      fail("The attribute start is not an allowed value: 'EAGER','LAZY'")
    }
    if $statistics_enabled != undef { 
      validate_bool($statistics_enabled)
    }
  

    $raw_options = { 
      'aliases'                      => $aliases,
      'default-cache'                => $default_cache,
      'eviction-executor'            => $eviction_executor,
      'jndi-name'                    => $jndi_name,
      'listener-executor'            => $listener_executor,
      'module'                       => $module,
      'replication-queue-executor'   => $replication_queue_executor,
      'start'                        => $start,
      'statistics-enabled'           => $statistics_enabled,
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
