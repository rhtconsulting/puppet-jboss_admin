# == Defines jboss_admin::ssl_configuration
#
# The SSL configuration of the connector.
#
# === Parameters
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
# [*protocol*]
#   The SSL protocols that are enabled.
#
# [*password*]
#   Password.
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
# [*cipher_suite*]
#   The allowed cipher suite.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_file*]
#   Server certificate file.
#
# [*name*]
#   The configuration name.
#
# [*truststore_type*]
#   Type of the truststore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*ca_certificate_password*]
#   Certificate password.
#
#
define jboss_admin::ssl_configuration (
  $server,
  $certificate_key_file           = undef,
  $ca_certificate_file            = undef,
  $key_alias                      = undef,
  $protocol                       = undef,
  $password                       = undef,
  $verify_client                  = undef,
  $session_cache_size             = undef,
  $verify_depth                   = undef,
  $keystore_type                  = undef,
  $session_timeout                = undef,
  $cipher_suite                   = undef,
  $ca_revocation_url              = undef,
  $certificate_file               = undef,
  $name                           = undef,
  $truststore_type                = undef,
  $ca_certificate_password        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $session_cache_size != undef && !is_integer($session_cache_size) { 
      fail('The attribute session_cache_size is not an integer') 
    }
    if $verify_depth != undef && !is_integer($verify_depth) { 
      fail('The attribute verify_depth is not an integer') 
    }
    if $session_timeout != undef && !is_integer($session_timeout) { 
      fail('The attribute session_timeout is not an integer') 
    }
  

    $raw_options = { 
      'certificate-key-file'         => $certificate_key_file,
      'ca-certificate-file'          => $ca_certificate_file,
      'key-alias'                    => $key_alias,
      'protocol'                     => $protocol,
      'password'                     => $password,
      'verify-client'                => $verify_client,
      'session-cache-size'           => $session_cache_size,
      'verify-depth'                 => $verify_depth,
      'keystore-type'                => $keystore_type,
      'session-timeout'              => $session_timeout,
      'cipher-suite'                 => $cipher_suite,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-file'             => $certificate_file,
      'name'                         => $name,
      'truststore-type'              => $truststore_type,
      'ca-certificate-password'      => $ca_certificate_password,
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
