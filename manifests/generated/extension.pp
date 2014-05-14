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
define jboss_admin::extension (
  $server,
  $module                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'module'                       => $module,
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
