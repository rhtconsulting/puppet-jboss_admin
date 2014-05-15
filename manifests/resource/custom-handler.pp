# == Defines jboss_admin::custom-handler
#
# Defines a custom logging handler. The custom handler must extend java.util.logging.Handler.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*properties*]
#   Defines the properties used for the logging handler. All properties must be accessible via a setter method.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*module*]
#   The module that the logging handler depends on.
#
# [*formatter*]
#   Defines a formatter.
#
# [*class*]
#   The logging handler class to be used.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*_name*]
#   The handler's name.
#
#
define jboss_admin::resource::custom-handler (
  $server,
  $filter                         = undef,
  $properties                     = undef,
  $encoding                       = undef,
  $module                         = undef,
  $formatter                      = undef,
  $class                          = undef,
  $level                          = undef,
  $_name                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'properties'                   => $properties,
      'encoding'                     => $encoding,
      'module'                       => $module,
      'formatter'                    => $formatter,
      'class'                        => $class,
      'level'                        => $level,
      'name'                         => $_name,
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
