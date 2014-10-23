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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $mapping_modules != undef and !is_array($mapping_modules) { 
      fail('The attribute mapping_modules is not an array') 
    }
  

    $raw_options = { 
      'mapping-modules'              => $mapping_modules,
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
