# == Defines jboss_admin::bundle
#
# Runtime bundle information.
#
# === Parameters
#
# [*version*]
#   The bundle version.
#
# [*startlevel*]
#   The bundle's start level.
#
# [*id*]
#   The bundle ID.
#
# [*symbolic_name*]
#   The bundle symbolic name.
#
#
define jboss_admin::resource::bundle (
  $server,
  $version                        = undef,
  $startlevel                     = undef,
  $id                             = undef,
  $symbolic_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef and !is_integer($startlevel) { 
      fail('The attribute startlevel is not an integer') 
    }
  

    $raw_options = { 
      'version'                      => $version,
      'startlevel'                   => $startlevel,
      'id'                           => $id,
      'symbolic-name'                => $symbolic_name,
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
