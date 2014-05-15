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
# [*overflow_action*]
#   Specify what action to take when the overflowing.  The valid options are 'block' and 'discard'
#
# [*queue_length*]
#   The queue length to use before flushing writing
#
#
define jboss_admin::resource::async-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $subhandlers                    = undef,
  $level                          = undef,
  $name                           = undef,
  $overflow_action                = undef,
  $queue_length                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $queue_length != undef and !is_integer($queue_length) { 
      fail('The attribute queue_length is not an integer') 
    }
  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'subhandlers'                  => $subhandlers,
      'level'                        => $level,
      'name'                         => $name,
      'overflow-action'              => $overflow_action,
      'queue-length'                 => $queue_length,
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
