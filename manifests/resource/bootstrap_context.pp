# == Defines jboss_admin::bootstrap_context
#
# jca.bootstrap-context
#
# === Parameters
#
# [*workmanager*]
#   The WorkManager instance for the BootstrapContext
#
# [*resource_name*]
#   The name of the BootstrapContext
#
#
define jboss_admin::resource::bootstrap_context (
  $server,
  $workmanager                    = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'workmanager'                  => $workmanager,
      'name'                         => $resource_name,
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
