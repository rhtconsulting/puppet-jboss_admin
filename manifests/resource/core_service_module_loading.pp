# == Defines jboss_admin::core_service_module_loading
#
# The modular classloading system.
#
# === Parameters
#
# [*module_roots*]
#   A list of filesystem locations under which the module loading system looks for modules, arranged in order of precedence.
#
#
define jboss_admin::resource::core_service_module_loading (
  $server,
  $module_roots                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'module-roots'                 => $module_roots,
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
