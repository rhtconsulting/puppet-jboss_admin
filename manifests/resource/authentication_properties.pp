# == Defines jboss_admin::authentication_properties
#
# Configuration to use a list users stored within a properties file as the user repository. The entries within the properties file are username={credentials} with each user being specified on it's own line.
#
# === Parameters
#
# [*path*]
#   The path of the properties file containing the users.
#
# [*plain_text*]
#   Are the credentials within the properties file stored in plain text. If not the credential is expected to be the hex encoded Digest hash of 'username : realm : password'.
#
# [*relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
#
define jboss_admin::resource::authentication_properties (
  $server,
  $path                           = undef,
  $plain_text                     = undef,
  $relative_to                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'path'                         => $path,
      'plain-text'                   => $plain_text,
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
