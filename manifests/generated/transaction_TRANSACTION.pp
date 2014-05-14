# == Defines jboss_admin::transaction_TRANSACTION
#
# The cache transaction configuration.
#
# === Parameters
#
# [*locking*]
#   The locking mode for this cache, one of OPTIMISTIC or PESSIMISTIC.
#
# [*stop_timeout*]
#   If there are any ongoing transactions when a cache is stopped, Infinispan waits for ongoing remote and local transactions to finish. The amount of time to wait for is defined by the cache stop timeout.
#
# [*mode*]
#   Sets the cache transaction mode to one of NONE, NON_XA, NON_DURABLE_XA, FULL_XA.
#
#
define jboss_admin::transaction_TRANSACTION (
  $server,
  $locking                        = undef,
  $stop_timeout                   = undef,
  $mode                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'locking'                      => $locking,
      'stop-timeout'                 => $stop_timeout,
      'mode'                         => $mode,
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
