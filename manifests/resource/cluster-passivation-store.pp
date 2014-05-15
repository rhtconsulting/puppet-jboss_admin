# == Defines jboss_admin::cluster-passivation-store
#
# A clustered passivation store
#
# === Parameters
#
# [*cache_container*]
#   The name of the cache container used for the bean and client-mappings caches
#
# [*max_size*]
#   The maximum number of beans this cache should store before forcing old beans to passivate
#
# [*client_mappings_cache*]
#   The name of the cache used to store client-mappings of the EJB remoting connector's socket-bindings
#
# [*idle_timeout_unit*]
#   The unit of idle-timeout
#
# [*idle_timeout*]
#   The timeout in units specified by idle-timeout-unit, after which a bean will passivate
#
# [*bean_cache*]
#   The name of the cache used to store bean instances.
#
# [*passivate_events_on_replicate*]
#   Indicates whether replication should trigger passivation events on the bean
#
#
define jboss_admin::resource::cluster-passivation-store (
  $server,
  $cache_container                = undef,
  $max_size                       = undef,
  $client_mappings_cache          = undef,
  $idle_timeout_unit              = undef,
  $idle_timeout                   = undef,
  $bean_cache                     = undef,
  $passivate_events_on_replicate  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_size != undef and !is_integer($max_size) { 
      fail('The attribute max_size is not an integer') 
    }
  

    $raw_options = { 
      'cache-container'              => $cache_container,
      'max-size'                     => $max_size,
      'client-mappings-cache'        => $client_mappings_cache,
      'idle-timeout-unit'            => $idle_timeout_unit,
      'idle-timeout'                 => $idle_timeout,
      'bean-cache'                   => $bean_cache,
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
