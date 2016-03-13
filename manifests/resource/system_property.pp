# == Defines jboss_admin::system_property
#
# A system property to set on the server.
#
# === Parameters
#
# [*value*]
#   The value of the system property.
#
#
define jboss_admin::resource::system_property (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'value'                        => $value,
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
