# == Defines jboss_admin::ssl
#
# The SSL configuration to client MCMP logic.
#
# === Parameters
#
# [*ca_certificate_file*]
#   Certificate authority.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_key_file*]
#   Key file for the certificate.
#
# [*cipher_suite*]
#   The allowed cipher suite.
#
# [*key_alias*]
#   The key alias.
#
# [*keystore_type*]
#   The keystore type.
#
# [*password*]
#   Password.
#
# [*protocol*]
#   The SSL protocols that are enabled.
#
#
define jboss_admin::resource::ssl (
  $server,
  $ca_certificate_file            = undef,
  $ca_revocation_url              = undef,
  $certificate_key_file           = undef,
  $cipher_suite                   = undef,
  $key_alias                      = undef,
  $keystore_type                  = undef,
  $password                       = undef,
  $protocol                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $ca_certificate_file != undef and !is_string($ca_certificate_file) { 
      fail('The attribute ca_certificate_file is not a string') 
    }
    if $ca_revocation_url != undef and !is_string($ca_revocation_url) { 
      fail('The attribute ca_revocation_url is not a string') 
    }
    if $certificate_key_file != undef and !is_string($certificate_key_file) { 
      fail('The attribute certificate_key_file is not a string') 
    }
    if $cipher_suite != undef and !is_string($cipher_suite) { 
      fail('The attribute cipher_suite is not a string') 
    }
    if $key_alias != undef and !is_string($key_alias) { 
      fail('The attribute key_alias is not a string') 
    }
    if $keystore_type != undef and !is_string($keystore_type) { 
      fail('The attribute keystore_type is not a string') 
    }
    if $password != undef and !is_string($password) { 
      fail('The attribute password is not a string') 
    }
    if $protocol != undef and !is_string($protocol) { 
      fail('The attribute protocol is not a string') 
    }
  

    $raw_options = { 
      'ca-certificate-file'          => $ca_certificate_file,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-key-file'         => $certificate_key_file,
      'cipher-suite'                 => $cipher_suite,
      'key-alias'                    => $key_alias,
      'keystore-type'                => $keystore_type,
      'password'                     => $password,
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
