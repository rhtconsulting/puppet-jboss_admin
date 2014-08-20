# == Defines jboss_admin::cluster_passivation_store
#
# A clustered passivation store
#
# === Parameters
#
# [*bean_cache*]
#   The name of the cache used to store bean instances.
#
# [*cache_container*]
#   The name of the cache container used for the bean and client-mappings caches
#
# [*client_mappings_cache*]
#   The name of the cache used to store client-mappings of the EJB remoting connector's socket-bindings
#
# [*idle_timeout*]
#   The timeout in units specified by idle-timeout-unit, after which a bean will passivate
#
# [*idle_timeout_unit*]
#   The unit of idle-timeout
#
# [*max_size*]
#   The maximum number of beans this cache should store before forcing old beans to passivate
#
# [*passivate_events_on_replicate*]
#   Indicates whether replication should trigger passivation events on the bean
#
#
define jboss_admin::resource::cluster_passivation_store (
  $server,
  $bean_cache                     = undef,
  $cache_container                = undef,
  $client_mappings_cache          = undef,
  $idle_timeout                   = undef,
  $idle_timeout_unit              = undef,
  $max_size                       = undef,
  $passivate_events_on_replicate  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_size != undef and !is_integer($max_size) { 
      fail('The attribute max_size is not an integer') 
    }
  

    $raw_options = { 
      'bean-cache'                   => $bean_cache,
      'cache-container'              => $cache_container,
      'client-mappings-cache'        => $client_mappings_cache,
      'idle-timeout'                 => $idle_timeout,
      'idle-timeout-unit'            => $idle_timeout_unit,
      'max-size'                     => $max_size,
      'passivate-events-on-replicate' => $passivate_events_on_replicate,
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
