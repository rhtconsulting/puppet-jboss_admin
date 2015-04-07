# == Defines jboss_admin::config_properties
#
# A custom defined config property.
#
# === Parameters
#
# [*value*]
#   Custom defined config property value.
#
#
define jboss_admin::resource::config_properties (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = {
      'value'                        => $value,
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
