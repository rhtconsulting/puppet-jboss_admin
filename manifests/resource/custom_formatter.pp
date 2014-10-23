# == Defines jboss_admin::custom_formatter
#
# A custom formatter to be used with handlers. Note that most log records are formatted in the printf format. Formatters may require invocation of the org.jboss.logmanager.ExtLogRecord#getFormattedMessage() for the message to be properly formatted.
#
# === Parameters
#
# [*class*]
#   The logging handler class to be used.
#
# [*module*]
#   The module that the logging handler depends on.
#
# [*properties*]
#   Defines the properties used for the logging handler. All properties must be accessible via a setter method.
#
#
define jboss_admin::resource::custom_formatter (
  $server,
  $class                          = undef,
  $module                         = undef,
  $properties                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $class != undef and !is_string($class) { 
      fail('The attribute class is not a string') 
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
  

    $raw_options = { 
      'class'                        => $class,
      'module'                       => $module,
      'properties'                   => $properties,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }


}
