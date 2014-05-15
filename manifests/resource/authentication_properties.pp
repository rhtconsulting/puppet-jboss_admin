# == Defines jboss_admin::authentication_properties
#
# Configuration to use a list users stored within a properties file as the user repository. The entries within the properties file are username={credentials} with each user being specified on it's own line.
#
# === Parameters
#
# [*relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
# [*path*]
#   The path of the properties file containing the users.
#
# [*plain_text*]
#   Are the credentials within the properties file stored in plain text. If not the credential is expected to be the hex encoded Digest hash of 'username : realm : password'.
#
#
define jboss_admin::resource::authentication_properties (
  $server,
  $relative_to                    = undef,
  $path                           = undef,
  $plain_text                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'path'                         => $path,
      'plain-text'                   => $plain_text,
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
