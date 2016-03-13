# == Defines jboss_admin::subsystem_osgi
#
# The OSGi subsystem configuration.
#
# === Parameters
#
# [*activation*]
#   Activation flag for the OSGi subsystem. Possible values: lazy, eager.
#
# [*startlevel*]
#   The current Start Level of the OSGi Framework. Changing this value will change the Start Level of the Framework accordingly.
#
#
define jboss_admin::resource::subsystem_osgi (
  $server,
  $activation                     = undef,
  $startlevel                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {
    if $startlevel != undef and $startlevel != undefined and !is_integer($startlevel) {
      fail('The attribute startlevel is not an integer')
    }

    $raw_options = {
      'activation'                   => $activation,
      'startlevel'                   => $startlevel,
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
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server
    }
  }
}
