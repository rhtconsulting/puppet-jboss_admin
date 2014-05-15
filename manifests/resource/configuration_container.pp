# == Defines jboss_admin::configuration_container
#
# Common container configuration
#
# === Parameters
#
# [*welcome_file*]
#   A welcome files declaration.
#
# [*mime_mapping*]
#   A mime-mapping definition.
#
#
define jboss_admin::resource::configuration_container (
  $server,
  $welcome_file                   = undef,
  $mime_mapping                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'welcome-file'                 => $welcome_file,
      'mime-mapping'                 => $mime_mapping,
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
