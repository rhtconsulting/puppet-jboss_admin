# == Defines jboss_admin::mixed-keyed-jdbc-store
#
# The cache store configuration.
#
# === Parameters
#
# [*singleton*]
#   If true, the singleton store cache store is enabled. SingletonStore is a delegating cache store used for situations when only one instance in a cluster should interact with the underlying store.
#
# [*datasource*]
#   A datasource reference for this datastore.
#
# [*shared*]
#   This setting should be set to true when multiple cache instances share the same cache store (e.g., multiple nodes in a cluster using a JDBC-based CacheStore pointing to the same, shared database.) Setting this to true avoids multiple cache instances writing the same modification multiple times. If enabled, only the node where the modification originated will write to the cache store. If disabled, each individual cache reacts to a potential remote update by storing the data to the cache store.
#
# [*preload*]
#   If true, when the cache starts, data stored in the cache store will be pre-loaded into memory. This is particularly useful when data in the cache store will be needed immediately after startup and you want to avoid cache operations being delayed as a result of loading this data lazily. Can be used to provide a 'warm-cache' on startup, however there is a performance penalty as startup time is affected by this process.
#
# [*fetch_state*]
#   If true, fetch persistent state when joining a cluster. If multiple cache stores are chained, only one of them can have this property enabled.
#
# [*binary_keyed_table*]
#   The database table used to store binary cache entries.
#
# [*passivation*]
#   If true, data is only written to the cache store when it is evicted from memory, a phenomenon known as 'passivation'. Next time the data is requested, it will be 'activated' which means that data will be brought back to memory and removed from the persistent store. f false, the cache store contains a copy of the contents in memory, so writes to cache result in cache store writes. This essentially gives you a 'write-through' configuration.
#
# [*purge*]
#   If true, purges this cache store when it starts up.
#
# [*string_keyed_table*]
#   The database table used to store cache entries.
#
#
define jboss_admin::resource::mixed-keyed-jdbc-store (
  $server,
  $singleton                      = undef,
  $datasource                     = undef,
  $shared                         = undef,
  $preload                        = undef,
  $fetch_state                    = undef,
  $binary_keyed_table             = undef,
  $passivation                    = undef,
  $purge                          = undef,
  $string_keyed_table             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'singleton'                    => $singleton,
      'datasource'                   => $datasource,
      'shared'                       => $shared,
      'preload'                      => $preload,
      'fetch-state'                  => $fetch_state,
      'binary-keyed-table'           => $binary_keyed_table,
      'passivation'                  => $passivation,
      'purge'                        => $purge,
      'string-keyed-table'           => $string_keyed_table,
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
