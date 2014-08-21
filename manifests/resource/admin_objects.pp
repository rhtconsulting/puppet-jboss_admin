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
  $path                           = $name
) {
  if $ensure == present {

    if $class_name != undef and !is_string($class_name) { 
      fail('The attribute class_name is not a string') 
    }
    if $enabled != undef and !is_bool($enabled) { 
      fail('The attribute enabled is not a boolean') 
    }
    if $jndi_name != undef and !is_string($jndi_name) { 
      fail('The attribute jndi_name is not a string') 
    }
    if $use_java_context != undef and !is_bool($use_java_context) { 
      fail('The attribute use_java_context is not a boolean') 
    }
  

    $raw_options = { 
      'class-name'                   => $class_name,
      'enabled'                      => $enabled,
      'jndi-name'                    => $jndi_name,
      'use-java-context'             => $use_java_context,
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
