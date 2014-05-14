# == Defines jboss_admin::expiration_EXPIRATION
#
# The cache expiration configuration.
#
# === Parameters
#
# [*lifespan*]
#   Maximum lifespan of a cache entry, after which the entry is expired cluster-wide, in milliseconds. -1 means the entries never expire.
#
# [*interval*]
#   Interval (in milliseconds) between subsequent runs to purge expired entries from memory and any cache stores. If you wish to disable the periodic eviction process altogether, set wakeupInterval to -1.
#
# [*max_idle*]
#   Maximum idle time a cache entry will be maintained in the cache, in milliseconds. If the idle time is exceeded, the entry will be expired cluster-wide. -1 means the entries never expire.
#
#
define jboss_admin::expiration_EXPIRATION (
  $server,
  $lifespan                       = undef,
  $interval                       = undef,
  $max_idle                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'lifespan'                     => $lifespan,
      'interval'                     => $interval,
      'max-idle'                     => $max_idle,
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
