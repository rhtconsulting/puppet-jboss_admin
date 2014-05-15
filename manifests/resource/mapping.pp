# == Defines jboss_admin::mapping
#
# Mapping configuration. Configures a list of mapping modules to be used for principal, role, attribute and credential mapping.
#
# === Parameters
#
# [*mapping_modules*]
#   List of modules that map principal, role, and credential information
#
#
define jboss_admin::resource::mapping (
  $server,
  $mapping_modules                = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'mapping-modules'              => $mapping_modules,
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
