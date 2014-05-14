# == Defines jboss_admin::logger
#
# Defines a logger category.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*handlers*]
#   The Handlers associated with this Logger.
#
# [*use_parent_handlers*]
#   Specifies whether or not this logger should send its output to it's parent Logger.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*category*]
#   Specifies the category for the logger.
#
#
define jboss_admin::logger (
  $server,
  $filter                         = undef,
  $handlers                       = undef,
  $use_parent_handlers            = undef,
  $level                          = undef,
  $category                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'handlers'                     => $handlers,
      'use-parent-handlers'          => $use_parent_handlers,
      'level'                        => $level,
      'category'                     => $category,
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
