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
  $path                           = $name
) {
  if $ensure == present {

    if $max_pool_size != undef and !is_integer($max_pool_size) { 
      fail('The attribute max_pool_size is not an integer') 
    }
  

    $raw_options = { 
      'max-pool-size'                => $max_pool_size,
      'timeout'                      => $timeout,
      'timeout-unit'                 => $timeout_unit,
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
