# == Defines jboss_admin::authentication_client_certificate_store
#
# Configuration for the keystore containing the client certificate if the syslog server requires authentication.
#
# === Parameters
#
# [*key_password*]
#   The password for the keystore key.
#
# [*keystore_password*]
#   The password for the keystore.
#
# [*keystore_path*]
#   =The path of the keystore.
#
# [*keystore_relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'keystore-relative-to' is provided, the value of the 'keystore-path' attribute is treated as relative to the path specified by this attribute.
#
#
define jboss_admin::resource::authentication_client_certificate_store (
  $server,
  $key_password                   = undef,
  $keystore_password              = undef,
  $keystore_path                  = undef,
  $keystore_relative_to           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $key_password != undef and !is_string($key_password) { 
      fail('The attribute key_password is not a string') 
    }
    if $keystore_password != undef and !is_string($keystore_password) { 
      fail('The attribute keystore_password is not a string') 
    }
    if $keystore_path != undef and !is_string($keystore_path) { 
      fail('The attribute keystore_path is not a string') 
    }
    if $keystore_relative_to != undef and !is_string($keystore_relative_to) { 
      fail('The attribute keystore_relative_to is not a string') 
    }
  

    $raw_options = { 
      'key-password'                 => $key_password,
      'keystore-password'            => $keystore_password,
      'keystore-path'                => $keystore_path,
      'keystore-relative-to'         => $keystore_relative_to,
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
