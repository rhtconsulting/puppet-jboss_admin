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
  $path                           = $name
) {
  if $ensure == present {

  

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
