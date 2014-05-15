# == Defines jboss_admin::sasl-policy
#
# The policy configuration.
#
# === Parameters
#
# [*no_anonymous*]
#   The optional nested "no-anonymous" element contains a boolean value which specifies whether mechanisms that accept anonymous login are permitted.  "false" to permit, "true" to deny.
#
# [*forward_secrecy*]
#   The optional nested "forward-secrecy" element contains a boolean value which specifies whether mechanisms that implement forward secrecy between sessions are required. Forward secrecy means that breaking into one session will not automatically provide information for breaking into future sessions.
#
# [*no_plain_text*]
#   The optional nested "no-plain-text" element contains a boolean value which specifies whether mechanisms susceptible to simple plain passive attacks (e.g., "PLAIN") are not permitted.    "false" to permit, "true" to deny.
#
# [*no_active*]
#   The optional nested "no-active" element contains a boolean value which specifies whether mechanisms susceptible to active (non-dictionary) attacks are not permitted. "false" to permit, "true" to deny.
#
# [*pass_credentials*]
#   The optional nested "pass-credentials" element contains a boolean value which specifies whether mechanisms that pass client credentials are required.
#
# [*no_dictionary*]
#   The optional nested "no-dictionary" element contains a boolean value which specifies whether mechanisms susceptible to passive dictionary attacks are permitted.  "false" to permit, "true" to deny.
#
#
define jboss_admin::resource::sasl-policy (
  $server,
  $no_anonymous                   = undef,
  $forward_secrecy                = undef,
  $no_plain_text                  = undef,
  $no_active                      = undef,
  $pass_credentials               = undef,
  $no_dictionary                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'no-anonymous'                 => $no_anonymous,
      'forward-secrecy'              => $forward_secrecy,
      'no-plain-text'                => $no_plain_text,
      'no-active'                    => $no_active,
      'pass-credentials'             => $pass_credentials,
      'no-dictionary'                => $no_dictionary,
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
