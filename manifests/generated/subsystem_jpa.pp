# == Defines jboss_admin::subsystem_jpa
#
# The configuration of the JPA subsystem.
#
# === Parameters
#
# [*default_datasource*]
#   The name of the default global datasource.
#
#
define jboss_admin::subsystem_jpa (
  $server,
  $default_datasource             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $default_datasource == undef { fail('The attribute default_datasource is undefined but required') }
  

    $raw_options = { 
      'default-datasource'           => $default_datasource,
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
