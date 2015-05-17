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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $forward_secrecy != undef and $forward_secrecy != undefined {
      validate_bool($forward_secrecy)
    }
    if $no_active != undef and $no_active != undefined {
      validate_bool($no_active)
    }
    if $no_anonymous != undef and $no_anonymous != undefined {
      validate_bool($no_anonymous)
    }
    if $no_dictionary != undef and $no_dictionary != undefined {
      validate_bool($no_dictionary)
    }
    if $no_plain_text != undef and $no_plain_text != undefined {
      validate_bool($no_plain_text)
    }
    if $pass_credentials != undef and $pass_credentials != undefined {
      validate_bool($pass_credentials)
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
