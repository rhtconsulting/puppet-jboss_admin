# == Defines jboss_admin::custom_handler
#
# Defines a custom logging handler. The custom handler must extend java.util.logging.Handler.
#
# === Parameters
#
# [*class*]
#   The logging handler class to be used.
#
# [*encoding*]
#   The character encoding used by this Handler.
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
# [*module*]
#   The module that the logging handler depends on.
#
# [*resource_name*]
#   The handler's name.
#
# [*properties*]
#   Defines the properties used for the logging handler. All properties must be accessible via a setter method.
#
#
define jboss_admin::resource::custom_handler (
  $server,
  $class                          = undef,
  $encoding                       = undef,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $module                         = undef,
  $resource_name                  = undef,
  $properties                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {



    $raw_options = {
      'class'                        => $class,
      'encoding'                     => $encoding,
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'module'                       => $module,
      'name'                         => $resource_name,
      'properties'                   => $properties,
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
