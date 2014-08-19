# == Defines jboss_admin::logger
#
# Defines a logger category.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*category*]
#   Specifies the category for the logger.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*handlers*]
#   The Handlers associated with this Logger.
#
# [*use_parent_handlers*]
#   Specifies whether or not this logger should send its output to it's parent Logger.
#
#
define jboss_admin::resource::logger (
  $server,
  $filter                         = undef,
  $category                       = undef,
  $level                          = undef,
  $handlers                       = undef,
  $use_parent_handlers            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'category'                     => $category,
      'level'                        => $level,
      'handlers'                     => $handlers,
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
