# == Defines jboss_admin::expiration
#
# The cache expiration configuration.
#
# === Parameters
#
# [*interval*]
#   Interval (in milliseconds) between subsequent runs to purge expired entries from memory and any cache stores. If you wish to disable the periodic eviction process altogether, set wakeupInterval to -1.
#
# [*lifespan*]
#   Maximum lifespan of a cache entry, after which the entry is expired cluster-wide, in milliseconds. -1 means the entries never expire.
#
# [*max_idle*]
#   Maximum idle time a cache entry will be maintained in the cache, in milliseconds. If the idle time is exceeded, the entry will be expired cluster-wide. -1 means the entries never expire.
#
#
define jboss_admin::resource::expiration (
  $server,
  $interval                       = undef,
  $lifespan                       = undef,
  $max_idle                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $interval != undef and !is_integer($interval) { 
      fail('The attribute interval is not an integer') 
    }
    if $lifespan != undef and !is_integer($lifespan) { 
      fail('The attribute lifespan is not an integer') 
    }
    if $max_idle != undef and !is_integer($max_idle) { 
      fail('The attribute max_idle is not an integer') 
    }
  

    $raw_options = { 
      'interval'                     => $interval,
      'lifespan'                     => $lifespan,
      'max-idle'                     => $max_idle,
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
