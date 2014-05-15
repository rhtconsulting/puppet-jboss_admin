# == Defines jboss_admin::locking
#
# The locking configuration of the cache.
#
# === Parameters
#
# [*isolation*]
#   Sets the cache locking isolation level.
#
# [*acquire_timeout*]
#   Maximum time to attempt a particular lock acquisition.
#
# [*striping*]
#   If true, a pool of shared locks is maintained for all entries that need to be locked. Otherwise, a lock is created per entry in the cache. Lock striping helps control memory footprint but may reduce concurrency in the system.
#
# [*concurrency_level*]
#   Concurrency level for lock containers. Adjust this value according to the number of concurrent threads interacting with Infinispan.
#
#
define jboss_admin::resource::locking (
  $server,
  $isolation                      = undef,
  $acquire_timeout                = undef,
  $striping                       = undef,
  $concurrency_level              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $concurrency_level != undef and !is_integer($concurrency_level) { 
      fail('The attribute concurrency_level is not an integer') 
    }
  

    $raw_options = { 
      'isolation'                    => $isolation,
      'acquire-timeout'              => $acquire_timeout,
      'striping'                     => $striping,
      'concurrency-level'            => $concurrency_level,
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
