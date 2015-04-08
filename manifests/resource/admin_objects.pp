# == Defines jboss_admin::admin_objects
#
# Specifies an administration object.
#
# === Parameters
#
# [*class_name*]
#   Specifies the fully qualified class name of an administration object.
#
# [*enabled*]
#   Specifies if the administration object should be enabled.
#
# [*jndi_name*]
#   Specifies the JNDI name for the administration object.
#
# [*use_java_context*]
#   Setting this to false will bind the object into global JNDI.
#
#
define jboss_admin::resource::admin_objects (
  $server,
  $class_name                     = undef,
  $enabled                        = undef,
  $jndi_name                      = undef,
  $use_java_context               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }
    if $use_java_context != undef and $use_java_context != undefined {
      validate_bool($use_java_context)
    }
  

    $raw_options = {
      'class-name'                   => $class_name,
      'enabled'                      => $enabled,
      'jndi-name'                    => $jndi_name,
      'use-java-context'             => $use_java_context,
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
