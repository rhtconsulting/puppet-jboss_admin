# == Defines jboss_admin::async-handler
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
# [*subhandlers*]
#   The Handlers associated with this async handler.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*name*]
#   The handler's name.
#
# [*queue_length*]
#   The queue length to use before flushing writing
#
# [*overflow_action*]
#   Specify what action to take when the overflowing.  The valid options are 'block' and 'discard'
#
#
define jboss_admin::async-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $subhandlers                    = undef,
  $level                          = undef,
  $name                           = undef,
  $queue_length                   = undef,
  $overflow_action                = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_length != undef && !is_integer($queue_length) { 
      fail('The attribute queue_length is not an integer') 
    }
  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'subhandlers'                  => $subhandlers,
      'level'                        => $level,
      'name'                         => $name,
      'queue-length'                 => $queue_length,
      'overflow-action'              => $overflow_action,
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
