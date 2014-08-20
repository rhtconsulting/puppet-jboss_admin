# == Defines jboss_admin::server_identity_ssl
#
# Configuration of the SSL identity of a server or host controller.
#
# === Parameters
#
# [*keystore_password*]
#   The password to open the keystore.
#
# [*keystore_path*]
#   The path of the keystore.
#
# [*keystore_relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
# [*protocol*]
#   The protocol to use when creating the SSLContext.
#
#
define jboss_admin::resource::server_identity_ssl (
  $server,
  $keystore_password              = undef,
  $keystore_path                  = undef,
  $keystore_relative_to           = undef,
  $protocol                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'keystore-password'            => $keystore_password,
      'keystore-path'                => $keystore_path,
      'keystore-relative-to'         => $keystore_relative_to,
      'protocol'                     => $protocol,
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
