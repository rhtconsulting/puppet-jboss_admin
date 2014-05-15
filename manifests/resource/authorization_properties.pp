# == Defines jboss_admin::authorization_properties
#
# Configuration to use properties file to load a users roles. The entries within the properties file are username={roles} where roles is a comma separated list of users roles.
#
# === Parameters
#
# [*relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
# [*path*]
#   The path of the properties file containing the users roles.
#
#
define jboss_admin::resource::authorization_properties (
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
