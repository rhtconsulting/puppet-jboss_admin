# == Defines jboss_admin::strict_max_bean_instance_pool
#
# A bean instance pool with a strict upper limit
#
# === Parameters
#
# [*max_pool_size*]
#   The maximum number of bean instances that the pool can hold at a given point in time
#
# [*timeout*]
#   The maximum amount of time to wait for a bean instance to be available from the pool
#
# [*timeout_unit*]
#   The instance acquisition timeout unit
#
#
define jboss_admin::resource::strict_max_bean_instance_pool (
  $server,
  $max_pool_size                  = undef,
  $timeout                        = undef,
  $timeout_unit                   = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $max_pool_size != undef and $max_pool_size != undefined and !is_integer($max_pool_size) {
      fail('The attribute max_pool_size is not an integer')
    }
    if $timeout != undef and $timeout != undefined and !is_integer($timeout) {
      fail('The attribute timeout is not an integer')
    }
    if $timeout_unit != undef and $timeout_unit != undefined and !($timeout_unit in ['NANOSECONDS','MICROSECONDS','MILLISECONDS','SECONDS','MINUTES','HOURS','DAYS']) {
      fail('The attribute timeout_unit is not an allowed value: "NANOSECONDS","MICROSECONDS","MILLISECONDS","SECONDS","MINUTES","HOURS","DAYS"')
    }

    $raw_options = {
      'max-pool-size'                => $max_pool_size,
      'timeout'                      => $timeout,
      'timeout-unit'                 => $timeout_unit,
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
