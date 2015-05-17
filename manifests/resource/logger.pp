# == Defines jboss_admin::logger
#
# Defines a logger category.
#
# === Parameters
#
# [*category*]
#   Specifies the category for the logger.
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
# [*use_parent_handlers*]
#   Specifies whether or not this logger should send its output to it's parent Logger.
#
#
define jboss_admin::resource::logger (
  $server,
  $category                       = undef,
  $filter                         = undef,
  $handlers                       = undef,
  $level                          = undef,
  $use_parent_handlers            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {



    $raw_options = {
      'category'                     => $category,
      'filter'                       => $filter,
      'handlers'                     => $handlers,
      'level'                        => $level,
      'use-parent-handlers'          => $use_parent_handlers,
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
