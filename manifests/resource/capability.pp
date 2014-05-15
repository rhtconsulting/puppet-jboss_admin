# == Defines jboss_admin::capability
#
# A framework capability. A capability maps to a JBoss Module in the modules directory or an OSGi bundle in the bundles directory. The identity maps to the resource identifier of the module or bundle.
#
# === Parameters
#
# [*startlevel*]
#   The startlevel for the capability. Can only be specified for OSGi bundles.
#
#
define jboss_admin::resource::capability (
  $server,
  $startlevel                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef and !is_integer($startlevel) { 
      fail('The attribute startlevel is not an integer') 
    }
  

    $raw_options = { 
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
