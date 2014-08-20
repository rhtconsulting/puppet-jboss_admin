# == Defines jboss_admin::state_transfer
#
# The state transfer configuration for distribution and replicated caches.
#
# === Parameters
#
# [*chunk_size*]
#   The size, in bytes, in which to batch the transfer of cache entries.
#
# [*enabled*]
#   If enabled, this will cause the cache to ask neighboring caches for state when it starts up, so the cache starts 'warm', although it will impact startup time.
#
# [*timeout*]
#   The maximum amount of time (ms) to wait for state from neighboring caches, before throwing an exception and aborting startup.
#
#
define jboss_admin::resource::state_transfer (
  $server,
  $chunk_size                     = undef,
  $enabled                        = undef,
  $timeout                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $chunk_size != undef and !is_integer($chunk_size) { 
      fail('The attribute chunk_size is not an integer') 
    }
  

    $raw_options = { 
      'chunk-size'                   => $chunk_size,
      'enabled'                      => $enabled,
      'timeout'                      => $timeout,
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
