# == Defines jboss_admin::ssl
#
# The SSL configuration of the connector.
#
# === Parameters
#
# [*ca_certificate_file*]
#   Certificate authority.
#
# [*ca_certificate_password*]
#   Certificate password.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_file*]
#   Server certificate file.
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
#   Type of the keystore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*resource_name*]
#   The configuration name.
#
# [*password*]
#   Password.
#
# [*protocol*]
#   The SSL protocols that are enabled.
#
# [*session_cache_size*]
#   SSL session cache.
#
# [*session_timeout*]
#   SSL session cache timeout.
#
# [*truststore_type*]
#   Type of the truststore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*verify_client*]
#   Enable client certificate verification.
#
# [*verify_depth*]
#   Limit certificate nesting.
#
#
define jboss_admin::resource::ssl (
  $server,
  $ca_certificate_file            = undef,
  $ca_certificate_password        = undef,
  $ca_revocation_url              = undef,
  $certificate_file               = undef,
  $certificate_key_file           = undef,
  $cipher_suite                   = undef,
  $key_alias                      = undef,
  $keystore_type                  = undef,
  $resource_name                  = undef,
  $password                       = undef,
  $protocol                       = undef,
  $session_cache_size             = undef,
  $session_timeout                = undef,
  $truststore_type                = undef,
  $verify_client                  = undef,
  $verify_depth                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $session_cache_size != undef and !is_integer($session_cache_size) { 
      fail('The attribute session_cache_size is not an integer') 
    }
    if $session_timeout != undef and !is_integer($session_timeout) { 
      fail('The attribute session_timeout is not an integer') 
    }
    if $verify_depth != undef and !is_integer($verify_depth) { 
      fail('The attribute verify_depth is not an integer') 
    }
  

    $raw_options = { 
      'ca-certificate-file'          => $ca_certificate_file,
      'ca-certificate-password'      => $ca_certificate_password,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-file'             => $certificate_file,
      'certificate-key-file'         => $certificate_key_file,
      'cipher-suite'                 => $cipher_suite,
      'key-alias'                    => $key_alias,
      'keystore-type'                => $keystore_type,
      'name'                         => $resource_name,
      'password'                     => $password,
      'protocol'                     => $protocol,
      'session-cache-size'           => $session_cache_size,
      'session-timeout'              => $session_timeout,
      'truststore-type'              => $truststore_type,
      'verify-client'                => $verify_client,
      'verify-depth'                 => $verify_depth,
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
