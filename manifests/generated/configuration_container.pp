# == Defines jboss_admin::configuration_container
#
# Common container configuration
#
# === Parameters
#
# [*mime_mapping*]
#   A mime-mapping definition.
#
# [*welcome_file*]
#   A welcome files declaration.
#
#
define jboss_admin::configuration_container (
  $server,
  $mime_mapping                   = undef,
  $welcome_file                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'mime-mapping'                 => $mime_mapping,
      'welcome-file'                 => $welcome_file,
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
