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
define jboss_admin::subsystem_osgi (
  $server,
  $activation                     = undef,
  $startlevel                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef && !is_integer($startlevel) { 
      fail('The attribute startlevel is not an integer') 
    }
  

    $raw_options = { 
      'activation'                   => $activation,
      'startlevel'                   => $startlevel,
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
