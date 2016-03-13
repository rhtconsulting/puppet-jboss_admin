# == Defines jboss_admin::cache_by_search_time
#
# A cache to hold the results of previous LDAP interactions.
#
# === Parameters
#
# [*cache_failures*]
#   Should failures be cached?
#
# [*cache_size*]
#   The current size of the cache.
#
# [*eviction_time*]
#   The time in seconds until an entry should be evicted from the cache.
#
# [*max_cache_size*]
#   The maximum size of the cache before the oldest items are removed to make room for new entries.
#
#
define jboss_admin::resource::cache_by_search_time (
  $server,
  $cache_failures                 = undef,
  $cache_size                     = undef,
  $eviction_time                  = undef,
  $max_cache_size                 = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $cache_failures != undef and $cache_failures != undefined {
      validate_bool($cache_failures)
    }
    if $cache_size != undef and $cache_size != undefined and !is_integer($cache_size) {
      fail('The attribute cache_size is not an integer')
    }
    if $eviction_time != undef and $eviction_time != undefined and !is_integer($eviction_time) {
      fail('The attribute eviction_time is not an integer')
    }
    if $max_cache_size != undef and $max_cache_size != undefined and !is_integer($max_cache_size) {
      fail('The attribute max_cache_size is not an integer')
    }

    $raw_options = {
      'cache-failures'               => $cache_failures,
      'cache-size'                   => $cache_size,
      'eviction-time'                => $eviction_time,
      'max-cache-size'               => $max_cache_size,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
