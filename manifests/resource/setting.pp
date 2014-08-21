# == Defines jboss_admin::setting
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
define jboss_admin::resource::setting (
  $server,
  $path                           = undef,
  $relative_to                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $path != undef and !is_string($path) { 
      fail('The attribute path is not a string') 
    }
    if $relative_to != undef and !is_string($relative_to) { 
      fail('The attribute relative_to is not a string') 
    }
  

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
