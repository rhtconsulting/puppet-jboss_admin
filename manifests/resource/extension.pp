# == Defines jboss_admin::extension
#
# A module that extends the standard capabilities of a domain or a standalone server.
#
# === Parameters
#
# [*module*]
#   The name of the module.
#
#
define jboss_admin::resource::extension (
  $server,
  $module                         = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
  

    $raw_options = { 
      'module'                       => $module,
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
