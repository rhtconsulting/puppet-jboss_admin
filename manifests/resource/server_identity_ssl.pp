# == Defines jboss_admin::server_identity_ssl
#
# Configuration of the SSL identity of a server or host controller.
#
# === Parameters
#
# [*alias*]
#   The alias of the entry to use from the keystore.
#
# [*key_password*]
#   The password to obtain the key from the keystore.
#
# [*keystore_password*]
#   The password to open the keystore.
#
# [*keystore_path*]
#   The path of the keystore, will be ignored if the keystore-provider is anything other than JKS.
#
# [*keystore_provider*]
#   The provider for loading the keystore, defaults to JKS.
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
  $alias                          = undef,
  $key_password                   = undef,
  $keystore_password              = undef,
  $keystore_path                  = undef,
  $keystore_provider              = undef,
  $keystore_relative_to           = undef,
  $protocol                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $alias != undef and !is_string($alias) { 
      fail('The attribute alias is not a string') 
    }
    if $key_password != undef and !is_string($key_password) { 
      fail('The attribute key_password is not a string') 
    }
    if $keystore_password != undef and !is_string($keystore_password) { 
      fail('The attribute keystore_password is not a string') 
    }
    if $keystore_path != undef and !is_string($keystore_path) { 
      fail('The attribute keystore_path is not a string') 
    }
    if $keystore_provider != undef and !is_string($keystore_provider) { 
      fail('The attribute keystore_provider is not a string') 
    }
    if $keystore_relative_to != undef and !is_string($keystore_relative_to) { 
      fail('The attribute keystore_relative_to is not a string') 
    }
    if $protocol != undef and !is_string($protocol) { 
      fail('The attribute protocol is not a string') 
    }
  

    $raw_options = { 
      'alias'                        => $alias,
      'key-password'                 => $key_password,
      'keystore-password'            => $keystore_password,
      'keystore-path'                => $keystore_path,
      'keystore-provider'            => $keystore_provider,
      'keystore-relative-to'         => $keystore_relative_to,
      'protocol'                     => $protocol,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }


}
