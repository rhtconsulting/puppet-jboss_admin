# == Defines jboss_admin::ssl
#
# The SSL configuration of the connector.
#
# === Parameters
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
# [*password*]
#   Password.
#
# [*ca_revocation_url*]
#   Certificate authority revocation list.
#
# [*certificate_file*]
#   Server certificate file.
#
# [*truststore_type*]
#   Type of the truststore, There are various types of keystores available, including "PKCS12" and Sun's "JKS."
#
# [*ca_certificate_password*]
#   Certificate password.
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
# [*resource_name*]
#   The configuration name.
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
#
define jboss_admin::resource::ssl (
  $server,
  $session_timeout                = undef,
  $protocol                       = undef,
  $cipher_suite                   = undef,
  $password                       = undef,
  $ca_revocation_url              = undef,
  $certificate_file               = undef,
  $truststore_type                = undef,
  $ca_certificate_password        = undef,
  $certificate_key_file           = undef,
  $ca_certificate_file            = undef,
  $key_alias                      = undef,
  $resource_name                  = undef,
  $verify_client                  = undef,
  $session_cache_size             = undef,
  $verify_depth                   = undef,
  $keystore_type                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $session_timeout != undef and !is_integer($session_timeout) { 
      fail('The attribute session_timeout is not an integer') 
    }
    if $session_cache_size != undef and !is_integer($session_cache_size) { 
      fail('The attribute session_cache_size is not an integer') 
    }
    if $verify_depth != undef and !is_integer($verify_depth) { 
      fail('The attribute verify_depth is not an integer') 
    }
  

    $raw_options = { 
      'session-timeout'              => $session_timeout,
      'protocol'                     => $protocol,
      'cipher-suite'                 => $cipher_suite,
      'password'                     => $password,
      'ca-revocation-url'            => $ca_revocation_url,
      'certificate-file'             => $certificate_file,
      'truststore-type'              => $truststore_type,
      'ca-certificate-password'      => $ca_certificate_password,
      'certificate-key-file'         => $certificate_key_file,
      'ca-certificate-file'          => $ca_certificate_file,
      'key-alias'                    => $key_alias,
      'name'                         => $resource_name,
      'verify-client'                => $verify_client,
      'session-cache-size'           => $session_cache_size,
      'verify-depth'                 => $verify_depth,
      'keystore-type'                => $keystore_type,
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
