# == Defines jboss_admin::bootstrap-context
#
# jca.bootstrap-context
#
# === Parameters
#
# [*workmanager*]
#   The WorkManager instance for the BootstrapContext
#
# [*_name*]
#   The name of the BootstrapContext
#
#
define jboss_admin::resource::bootstrap-context (
  $server,
  $workmanager                    = undef,
  $_name                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'workmanager'                  => $workmanager,
      'name'                         => $_name,
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
