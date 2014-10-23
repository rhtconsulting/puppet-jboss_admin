# == Defines jboss_admin::active_operation
#
# A currently executing operation.
#
# === Parameters
#
# [*access_mechanism*]
#   The mechanism used to submit a request to the server.
#
# [*address*]
#   The address of the resource targeted by the operation. The value in the final element of the address will be '<hidden>' if the caller is not authorized to address the operation's target resource.
#
# [*caller_thread*]
#   The name of the thread that is executing the operation.
#
# [*cancelled*]
#   Whether the operation has been cancelled.
#
# [*exclusive_running_time*]
#   Amount of time the operation has been executing with the exclusive operation execution lock held, or -1 if the operation does not hold the exclusive execution lock.
#
# [*execution_status*]
#   The current activity of the operation.
#
# [*operation*]
#   The name of the operation, or '<hidden>' if the caller is not authorized to address the operation's target resource.
#
# [*running_time*]
#   Amount of time the operation has been executing.
#
#
define jboss_admin::resource::active_operation (
  $server,
  $access_mechanism               = undef,
  $address                        = undef,
  $caller_thread                  = undef,
  $cancelled                      = undef,
  $exclusive_running_time         = undef,
  $execution_status               = undef,
  $operation                      = undef,
  $running_time                   = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $access_mechanism != undef and !is_string($access_mechanism) { 
      fail('The attribute access_mechanism is not a string') 
    }
    if $access_mechanism != undef and !($access_mechanism in ['NATIVE','HTTP','JMX']) {
      fail("The attribute access_mechanism is not an allowed value: 'NATIVE','HTTP','JMX'")
    }
    if $address != undef and !is_array($address) { 
      fail('The attribute address is not an array') 
    }
    if $caller_thread != undef and !is_string($caller_thread) { 
      fail('The attribute caller_thread is not a string') 
    }
    if $cancelled != undef { 
      validate_bool($cancelled)
    }
    if $exclusive_running_time != undef and !is_integer($exclusive_running_time) { 
      fail('The attribute exclusive_running_time is not an integer') 
    }
    if $execution_status != undef and !is_string($execution_status) { 
      fail('The attribute execution_status is not a string') 
    }
    if $execution_status != undef and !($execution_status in ['executing','awaiting-other-operation','awaiting-stability','completing','rolling-back']) {
      fail("The attribute execution_status is not an allowed value: 'executing','awaiting-other-operation','awaiting-stability','completing','rolling-back'")
    }
    if $operation != undef and !is_string($operation) { 
      fail('The attribute operation is not a string') 
    }
    if $running_time != undef and !is_integer($running_time) { 
      fail('The attribute running_time is not an integer') 
    }
  

    $raw_options = { 
      'access-mechanism'             => $access_mechanism,
      'address'                      => $address,
      'caller-thread'                => $caller_thread,
      'cancelled'                    => $cancelled,
      'exclusive-running-time'       => $exclusive_running_time,
      'execution-status'             => $execution_status,
      'operation'                    => $operation,
      'running-time'                 => $running_time,
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
