# == Defines jboss_admin::bundle
#
# Runtime bundle information.
#
# === Parameters
#
# [*id*]
#   The bundle ID.
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
#
define jboss_admin::resource::bundle (
  $server,
  $id                             = undef,
  $startlevel                     = undef,
  $symbolic_name                  = undef,
  $version                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $startlevel != undef and $startlevel != undefined and !is_integer($startlevel) {
      fail('The attribute startlevel is not an integer')
    }


    $raw_options = {
      'id'                           => $id,
      'startlevel'                   => $startlevel,
      'symbolic-name'                => $symbolic_name,
      'version'                      => $version,
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
