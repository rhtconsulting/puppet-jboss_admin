# == Defines jboss_admin::mapping_module
#
# List of modules that map principal, role, and credential information
#
# === Parameters
#
# [*code*]
#   Class name of the module to be instantiated.
#
# [*module*]
#   Name of JBoss Module where the mapping module code is located.
#
# [*module_options*]
#   List of module options containing a name/value pair.
#
# [*type*]
#   Type of mapping this module performs. Allowed values are principal, role, attribute or credential..
#
#
define jboss_admin::resource::mapping_module (
  $server,
  $code                           = undef,
  $module                         = undef,
  $module_options                 = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'code'                         => $code,
      'module'                       => $module,
      'module-options'               => $module_options,
      'type'                         => $type,
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
