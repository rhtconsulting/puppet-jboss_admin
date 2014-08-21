# == Defines jboss_admin::sasl_policy
#
# The policy configuration.
#
# === Parameters
#
# [*forward_secrecy*]
#   The optional nested "forward-secrecy" element contains a boolean value which specifies whether mechanisms that implement forward secrecy between sessions are required. Forward secrecy means that breaking into one session will not automatically provide information for breaking into future sessions.
#
# [*no_active*]
#   The optional nested "no-active" element contains a boolean value which specifies whether mechanisms susceptible to active (non-dictionary) attacks are not permitted. "false" to permit, "true" to deny.
#
# [*no_anonymous*]
#   The optional nested "no-anonymous" element contains a boolean value which specifies whether mechanisms that accept anonymous login are permitted.  "false" to permit, "true" to deny.
#
# [*no_dictionary*]
#   The optional nested "no-dictionary" element contains a boolean value which specifies whether mechanisms susceptible to passive dictionary attacks are permitted.  "false" to permit, "true" to deny.
#
# [*no_plain_text*]
#   The optional nested "no-plain-text" element contains a boolean value which specifies whether mechanisms susceptible to simple plain passive attacks (e.g., "PLAIN") are not permitted.    "false" to permit, "true" to deny.
#
# [*pass_credentials*]
#   The optional nested "pass-credentials" element contains a boolean value which specifies whether mechanisms that pass client credentials are required.
#
#
define jboss_admin::resource::sasl_policy (
  $server,
  $forward_secrecy                = undef,
  $no_active                      = undef,
  $no_anonymous                   = undef,
  $no_dictionary                  = undef,
  $no_plain_text                  = undef,
  $pass_credentials               = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $forward_secrecy != undef and !is_bool($forward_secrecy) { 
      fail('The attribute forward_secrecy is not a boolean') 
    }
    if $no_active != undef and !is_bool($no_active) { 
      fail('The attribute no_active is not a boolean') 
    }
    if $no_anonymous != undef and !is_bool($no_anonymous) { 
      fail('The attribute no_anonymous is not a boolean') 
    }
    if $no_dictionary != undef and !is_bool($no_dictionary) { 
      fail('The attribute no_dictionary is not a boolean') 
    }
    if $no_plain_text != undef and !is_bool($no_plain_text) { 
      fail('The attribute no_plain_text is not a boolean') 
    }
    if $pass_credentials != undef and !is_bool($pass_credentials) { 
      fail('The attribute pass_credentials is not a boolean') 
    }
  

    $raw_options = { 
      'forward-secrecy'              => $forward_secrecy,
      'no-active'                    => $no_active,
      'no-anonymous'                 => $no_anonymous,
      'no-dictionary'                => $no_dictionary,
      'no-plain-text'                => $no_plain_text,
      'pass-credentials'             => $pass_credentials,
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
