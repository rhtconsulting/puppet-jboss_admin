# == Defines jboss_admin::subsystem_datasources
#
# The data-sources subsystem, used to declare JDBC data-sources
#
# === Parameters
#
# [*installed_drivers*]
#   List of JDBC drivers that have been installed in the runtime
#
#
define jboss_admin::subsystem_datasources (
  $server,
  $installed_drivers              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $installed_drivers == undef { fail('The attribute installed_drivers is undefined but required') }
  

    $raw_options = { 
      'installed-drivers'            => $installed_drivers,
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
