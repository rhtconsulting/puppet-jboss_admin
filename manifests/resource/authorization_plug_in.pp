# == Defines jboss_admin::authorization_plug_in
#
# Configuration of a user store plug-in for use by the realm.
#
# === Parameters
#
# [*resource_name*]
#   The short name of the plug-in (as registered) to use.
#
#
define jboss_admin::resource::authorization_plug_in (
  $server,
  $resource_name                  = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'name'                         => $resource_name,
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
