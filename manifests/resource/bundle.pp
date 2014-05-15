# == Defines jboss_admin::bundle
#
# Runtime bundle information.
#
# === Parameters
#
# [*startlevel*]
#   The bundle's start level.
#
# [*version*]
#   The bundle version.
#
# [*symbolic_name*]
#   The bundle symbolic name.
#
# [*id*]
#   The bundle ID.
#
#
define jboss_admin::resource::bundle (
  $server,
  $startlevel                     = undef,
  $version                        = undef,
  $symbolic_name                  = undef,
  $id                             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef and !is_integer($startlevel) { 
      fail('The attribute startlevel is not an integer') 
    }
  

    $raw_options = { 
      'startlevel'                   => $startlevel,
      'version'                      => $version,
      'symbolic-name'                => $symbolic_name,
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
