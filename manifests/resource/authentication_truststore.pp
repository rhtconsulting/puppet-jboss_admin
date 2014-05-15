# == Defines jboss_admin::authentication_truststore
#
# Configuration of a keystore to use to create a trust manager to verify clients.
#
# === Parameters
#
# [*keystore_path*]
#   The path of the keystore.
#
# [*keystore_relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
# [*keystore_password*]
#   The password to open the keystore.
#
#
define jboss_admin::resource::authentication_truststore (
  $server,
  $keystore_path                  = undef,
  $keystore_relative_to           = undef,
  $keystore_password              = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'keystore-path'                => $keystore_path,
      'keystore-relative-to'         => $keystore_relative_to,
      'keystore-password'            => $keystore_password,
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
