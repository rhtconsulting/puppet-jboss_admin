# == Defines jboss_admin::eviction_EVICTION
#
# The cache eviction configuration.
#
# === Parameters
#
# [*max_entries*]
#   Maximum number of entries in a cache instance. If selected value is not a power of two the actual value will default to the least power of two larger than selected value. -1 means no limit.
#
# [*strategy*]
#   Sets the cache eviction strategy. Available options are 'UNORDERED', 'FIFO', 'LRU', 'LIRS' and 'NONE' (to disable eviction).
#
#
define jboss_admin::eviction_EVICTION (
  $server,
  $max_entries                    = undef,
  $strategy                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_entries != undef && !is_integer($max_entries) { 
      fail('The attribute max_entries is not an integer') 
    }
  

    $raw_options = { 
      'max-entries'                  => $max_entries,
      'strategy'                     => $strategy,
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
