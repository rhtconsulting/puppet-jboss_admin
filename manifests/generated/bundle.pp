# == Defines jboss_admin::bundle
#
# Runtime bundle information.
#
# === Parameters
#
# [*startlevel*]
#   The bundle's start level.
#
# [*symbolic_name*]
#   The bundle symbolic name.
#
# [*version*]
#   The bundle version.
#
# [*id*]
#   The bundle ID.
#
#
define jboss_admin::bundle (
  $server,
  $startlevel                     = undef,
  $symbolic_name                  = undef,
  $version                        = undef,
  $id                             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef && !is_integer($startlevel) { 
      fail('The attribute startlevel is not an integer') 
    }
  

    $raw_options = { 
      'startlevel'                   => $startlevel,
      'symbolic-name'                => $symbolic_name,
      'version'                      => $version,
      'id'                           => $id,
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
