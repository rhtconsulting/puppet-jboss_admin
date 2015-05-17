# == Defines jboss_admin::exclude
#
# An individual principal used within a role mapping.
#
# === Parameters
#
# [*resource_name*]
#   The name of the user or group being mapped.
#
# [*realm*]
#   An optional attribute to map based on the realm used for authentication.
#
# [*type*]
#   The type of the Principal being mapped, either 'group' or 'user'.
#
#
define jboss_admin::resource::exclude (
  $server,
  $resource_name                  = undef,
  $realm                          = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $type != undef and $type != undefined and !($type in ['GROUP','USER']) {
      fail('The attribute type is not an allowed value: "GROUP","USER"')
    }

    $raw_options = {
      'name'                         => $resource_name,
      'realm'                        => $realm,
      'type'                         => $type,
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
