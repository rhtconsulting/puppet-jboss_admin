# == Defines jboss_admin::remote_store
#
# The cache remote store configuration.
#
# === Parameters
#
# [*cache*]
#   The name of the remote cache to use for this remote store.
#
# [*fetch_state*]
#   If true, fetch persistent state when joining a cluster. If multiple cache stores are chained, only one of them can have this property enabled.
#
# [*passivation*]
#   If true, data is only written to the cache store when it is evicted from memory, a phenomenon known as 'passivation'. Next time the data is requested, it will be 'activated' which means that data will be brought back to memory and removed from the persistent store. f false, the cache store contains a copy of the contents in memory, so writes to cache result in cache store writes. This essentially gives you a 'write-through' configuration.
#
# [*preload*]
#   If true, when the cache starts, data stored in the cache store will be pre-loaded into memory. This is particularly useful when data in the cache store will be needed immediately after startup and you want to avoid cache operations being delayed as a result of loading this data lazily. Can be used to provide a 'warm-cache' on startup, however there is a performance penalty as startup time is affected by this process.
#
# [*purge*]
#   If true, purges this cache store when it starts up.
#
# [*remote_servers*]
#   A list of remote servers for this cache store.
#
# [*shared*]
#   This setting should be set to true when multiple cache instances share the same cache store (e.g., multiple nodes in a cluster using a JDBC-based CacheStore pointing to the same, shared database.) Setting this to true avoids multiple cache instances writing the same modification multiple times. If enabled, only the node where the modification originated will write to the cache store. If disabled, each individual cache reacts to a potential remote update by storing the data to the cache store.
#
# [*singleton*]
#   If true, the singleton store cache store is enabled. SingletonStore is a delegating cache store used for situations when only one instance in a cluster should interact with the underlying store.
#
# [*socket_timeout*]
#   A socket timeout for remote cache communication.
#
# [*tcp_no_delay*]
#   A TCP_NODELAY value for remote cache communication.
#
#
define jboss_admin::resource::remote_store (
  $server,
  $cache                          = undef,
  $fetch_state                    = undef,
  $passivation                    = undef,
  $preload                        = undef,
  $purge                          = undef,
  $remote_servers                 = undef,
  $shared                         = undef,
  $singleton                      = undef,
  $socket_timeout                 = undef,
  $tcp_no_delay                   = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $cache != undef and !is_string($cache) { 
      fail('The attribute cache is not a string') 
    }
    if $fetch_state != undef { 
      validate_bool($fetch_state)
    }
    if $passivation != undef { 
      validate_bool($passivation)
    }
    if $preload != undef { 
      validate_bool($preload)
    }
    if $purge != undef { 
      validate_bool($purge)
    }
    if $remote_servers != undef and !is_array($remote_servers) { 
      fail('The attribute remote_servers is not an array') 
    }
    if $shared != undef { 
      validate_bool($shared)
    }
    if $singleton != undef { 
      validate_bool($singleton)
    }
    if $socket_timeout != undef and !is_integer($socket_timeout) { 
      fail('The attribute socket_timeout is not an integer') 
    }
    if $tcp_no_delay != undef { 
      validate_bool($tcp_no_delay)
    }
  

    $raw_options = { 
      'cache'                        => $cache,
      'fetch-state'                  => $fetch_state,
      'passivation'                  => $passivation,
      'preload'                      => $preload,
      'purge'                        => $purge,
      'remote-servers'               => $remote_servers,
      'shared'                       => $shared,
      'singleton'                    => $singleton,
      'socket-timeout'               => $socket_timeout,
      'tcp-no-delay'                 => $tcp_no_delay,
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
