# == Defines jboss_admin::security_realm
#
# A security realm that can be associated with a management interface and used to control access to the management services.
#
# === Parameters
#
# [*map_groups_to_roles*]
#   After a users group membership has been loaded should a 1:1 relationship be assumed regarding group to role mapping.
#
#
define jboss_admin::resource::security_realm (
  $server,
  $map_groups_to_roles            = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $map_groups_to_roles != undef and $map_groups_to_roles != undefined {
      validate_bool($map_groups_to_roles)
    }

    $raw_options = {
      'map-groups-to-roles'          => $map_groups_to_roles,
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
