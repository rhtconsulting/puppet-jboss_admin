# == Defines jboss_admin::state_transfer
#
# The state transfer configuration for distribution and replicated caches.
#
# === Parameters
#
# [*timeout*]
#   The maximum amount of time (ms) to wait for state from neighboring caches, before throwing an exception and aborting startup.
#
# [*enabled*]
#   If enabled, this will cause the cache to ask neighboring caches for state when it starts up, so the cache starts 'warm', although it will impact startup time.
#
# [*chunk_size*]
#   The size, in bytes, in which to batch the transfer of cache entries.
#
#
define jboss_admin::resource::state_transfer (
  $server,
  $timeout                        = undef,
  $enabled                        = undef,
  $chunk_size                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $chunk_size != undef and !is_integer($chunk_size) { 
      fail('The attribute chunk_size is not an integer') 
    }
  

    $raw_options = { 
      'timeout'                      => $timeout,
      'enabled'                      => $enabled,
      'chunk-size'                   => $chunk_size,
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
