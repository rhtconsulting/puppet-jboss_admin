# == Defines jboss_admin::provider_module
#
# List of modules that map principal, role, and credential information
#
# === Parameters
#
# [*code*]
#   Class name of the module to be instantiated.
#
# [*module_options*]
#   List of module options containing a name/value pair.
#
#
define jboss_admin::resource::provider_module (
  $server,
  $code                           = undef,
  $module_options                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'code'                         => $code,
      'module-options'               => $module_options,
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
