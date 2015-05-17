# == Defines jboss_admin::root_logger
#
# Defines the root logger for this log context.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*handlers*]
#   The Handlers associated with this Logger.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
#
define jboss_admin::resource::root_logger (
  $server,
  $filter                         = undef,
  $handlers                       = undef,
  $level                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {



    $raw_options = {
      'filter'                       => $filter,
      'handlers'                     => $handlers,
      'level'                        => $level,
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
