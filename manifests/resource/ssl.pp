# == Defines jboss_admin::ssl
#
# The SSL configuration of the connector.
#
# === Parameters
#
# [*truststore_type*]
#   Type of the truststore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*ca_certificate_password*]
#   Certificate password.
#
# [*password*]
#   Password.
#
# [*certificate_key_file*]
#   Key file for the certificate.
#
# [*ca_certificate_file*]
#   Certificate authority.
#
# [*key_alias*]
#   The key alias.
#
# [*verify_client*]
#   Enable client certificate verification.
#
# [*session_cache_size*]
#   SSL session cache.
#
# [*verify_depth*]
#   Limit certificate nesting.
#
# [*keystore_type*]
#   Type of the keystore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*session_timeout*]
#   SSL session cache timeout.
#
# [*protocol*]
#   The SSL protocols that are enabled.
#
# [*cipher_suite*]
#   The allowed cipher suite.
#
# [*_name*]
#   The configuration name.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_file*]
#   Server certificate file.
#
#
define jboss_admin::resource::ssl (
  $server,
  $truststore_type                = undef,
  $ca_certificate_password        = undef,
  $password                       = undef,
  $certificate_key_file           = undef,
  $ca_certificate_file            = undef,
  $key_alias                      = undef,
  $verify_client                  = undef,
  $session_cache_size             = undef,
  $verify_depth                   = undef,
  $keystore_type                  = undef,
  $session_timeout                = undef,
  $protocol                       = undef,
  $cipher_suite                   = undef,
  $_name                          = undef,
  $ca_revocation_url              = undef,
  $certificate_file               = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $session_cache_size != undef and !is_integer($session_cache_size) { 
      fail('The attribute session_cache_size is not an integer') 
    }
    if $verify_depth != undef and !is_integer($verify_depth) { 
      fail('The attribute verify_depth is not an integer') 
    }
    if $session_timeout != undef and !is_integer($session_timeout) { 
      fail('The attribute session_timeout is not an integer') 
    }
  

    $raw_options = { 
      'truststore-type'              => $truststore_type,
      'ca-certificate-password'      => $ca_certificate_password,
      'password'                     => $password,
      'certificate-key-file'         => $certificate_key_file,
      'ca-certificate-file'          => $ca_certificate_file,
      'key-alias'                    => $key_alias,
      'verify-client'                => $verify_client,
      'session-cache-size'           => $session_cache_size,
      'verify-depth'                 => $verify_depth,
      'keystore-type'                => $keystore_type,
      'session-timeout'              => $session_timeout,
      'protocol'                     => $protocol,
      'cipher-suite'                 => $cipher_suite,
      'name'                         => $_name,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-file'             => $certificate_file,
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
