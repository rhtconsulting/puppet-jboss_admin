# == Defines jboss_admin::root_logger
#
# Defines the root logger for this log context.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*handlers*]
#   The Handlers associated with this Logger.
#
#
define jboss_admin::resource::root_logger (
  $server,
  $filter                         = undef,
  $level                          = undef,
  $handlers                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'level'                        => $level,
      'handlers'                     => $handlers,
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
