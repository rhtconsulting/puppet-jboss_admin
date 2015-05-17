# == Defines jboss_admin::async_handler
#
# Defines a handler which writes to the sub-handlers in an asynchronous thread. Used for handlers which introduce a substantial amount of lag.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*resource_name*]
#   The handler's name.
#
# [*overflow_action*]
#   Specify what action to take when the overflowing.  The valid options are 'block' and 'discard'
#
# [*queue_length*]
#   The queue length to use before flushing writing
#
# [*subhandlers*]
#   The Handlers associated with this async handler.
#
#
define jboss_admin::resource::async_handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $overflow_action                = undef,
  $queue_length                   = undef,
  $subhandlers                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_length != undef and $queue_length != undefined and !is_integer($queue_length) {
      fail('The attribute queue_length is not an integer')
    }


    $raw_options = {
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'name'                         => $resource_name,
      'overflow-action'              => $overflow_action,
      'queue-length'                 => $queue_length,
      'subhandlers'                  => $subhandlers,
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
