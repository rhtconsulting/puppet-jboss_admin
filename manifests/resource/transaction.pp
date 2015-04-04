# == Defines jboss_admin::transaction
#
# The cache transaction configuration.
#
# === Parameters
#
# [*locking*]
#   The locking configuration of the cache.
#
# [*mode*]
#   Sets the clustered cache mode, ASYNC for asynchronous operation, or SYNC for synchronous operation.
#
# [*stop_timeout*]
#   If there are any ongoing transactions when a cache is stopped, Infinispan waits for ongoing remote and local transactions to finish. The amount of time to wait for is defined by the cache stop timeout.
#
#
define jboss_admin::resource::transaction (
  $server,
  $locking                        = undef,
  $mode                           = undef,
  $stop_timeout                   = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $locking != undef and !($locking in ['OPTIMISTIC','PESSIMISTIC']) {
      fail("The attribute locking is not an allowed value: 'OPTIMISTIC','PESSIMISTIC'")
    }
    if $mode != undef and !($mode in ['NONE','NON_XA','NON_DURABLE_XA','FULL_XA']) {
      fail("The attribute mode is not an allowed value: 'NONE','NON_XA','NON_DURABLE_XA','FULL_XA'")
    }
    if $stop_timeout != undef and !is_integer($stop_timeout) {
      fail('The attribute stop_timeout is not an integer')
    }
  

    $raw_options = {
      'locking'                      => $locking,
      'mode'                         => $mode,
      'stop-timeout'                 => $stop_timeout,
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
