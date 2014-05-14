# == Defines jboss_admin::bootstrap-context
#
# jca.bootstrap-context
#
# === Parameters
#
# [*name*]
#   The name of the BootstrapContext
#
# [*workmanager*]
#   The WorkManager instance for the BootstrapContext
#
#
define jboss_admin::bootstrap-context (
  $server,
  $name                           = undef,
  $workmanager                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'name'                         => $name,
      'workmanager'                  => $workmanager,
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
