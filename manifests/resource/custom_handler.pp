# == Defines jboss_admin::custom_handler
#
# Defines a custom logging handler. The custom handler must extend java.util.logging.Handler.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
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
# [*formatter*]
#   Defines a formatter.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*resource_name*]
#   The handler's name.
#
#
define jboss_admin::resource::custom_handler (
  $server,
  $filter                         = undef,
  $encoding                       = undef,
  $class                          = undef,
  $properties                     = undef,
  $module                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'encoding'                     => $encoding,
      'class'                        => $class,
      'properties'                   => $properties,
      'module'                       => $module,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'name'                         => $resource_name,
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
