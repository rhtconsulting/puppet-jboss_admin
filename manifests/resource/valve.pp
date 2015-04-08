# == Defines jboss_admin::valve
#
# A global valve.
#
# === Parameters
#
# [*class_name*]
#   Name of the class containing the Valve
#
# [*enabled*]
#   Defines whether the Valve should be started on startup.
#
# [*module*]
#   Module where to find the valve.
#
# [*param*]
#   Parameter for the Valve like param-name="name" param-value="value"
#
#
define jboss_admin::resource::valve (
  $server,
  $class_name                     = undef,
  $enabled                        = undef,
  $module                         = undef,
  $param                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }
  

    $raw_options = {
      'class-name'                   => $class_name,
      'enabled'                      => $enabled,
      'module'                       => $module,
      'param'                        => $param,
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
