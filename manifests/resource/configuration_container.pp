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
define jboss_admin::resource::configuration_container (
  $server,
  $mime_mapping                   = undef,
  $welcome_file                   = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $welcome_file != undef and $welcome_file != undefined and !is_array($welcome_file) {
      fail('The attribute welcome_file is not an array')
    }

    $raw_options = {
      'mime-mapping'                 => $mime_mapping,
      'welcome-file'                 => $welcome_file,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
