# == Defines jboss_admin::directory
#
# The location for the access logging.
#
# === Parameters
#
# [*path*]
#   The relative folder path.
#
# [*relative_to*]
#   The folder the path is relative to.
#
#
define jboss_admin::resource::directory (
  $server,
  $path                           = undef,
  $relative_to                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'path'                         => $path,
      'relative-to'                  => $relative_to,
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
