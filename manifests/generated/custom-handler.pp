# == Defines jboss_admin::custom-handler
#
# Defines a custom logging handler. The custom handler must extend java.util.logging.Handler.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*class*]
#   The logging handler class to be used.
#
# [*properties*]
#   Defines the properties used for the logging handler. All properties must be accessible via a setter method.
#
# [*module*]
#   The module that the logging handler depends on.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*name*]
#   The handler's name.
#
#
define jboss_admin::custom-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $encoding                       = undef,
  $class                          = undef,
  $properties                     = undef,
  $module                         = undef,
  $level                          = undef,
  $name                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'encoding'                     => $encoding,
      'class'                        => $class,
      'properties'                   => $properties,
      'module'                       => $module,
      'level'                        => $level,
      'name'                         => $name,
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
