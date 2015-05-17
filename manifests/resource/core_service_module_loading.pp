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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $module_roots != undef and $module_roots != undefined and !is_array($module_roots) {
      fail('The attribute module_roots is not an array')
    }

    $raw_options = {
      'module-roots'                 => $module_roots,
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
