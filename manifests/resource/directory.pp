# == Defines jboss_admin::directory
#
# The location for the access logging.
#
# === Parameters
#
# [*relative_to*]
#   The folder the path is relative to.
#
# [*path*]
#   The relative folder path.
#
#
define jboss_admin::resource::directory (
  $server,
  $relative_to                    = undef,
  $path                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'path'                         => $path,
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
