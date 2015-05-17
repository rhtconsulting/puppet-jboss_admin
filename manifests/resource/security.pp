# == Defines jboss_admin::security
#
# The "sasl" element contains the SASL authentication configuration for this connector.
#
# === Parameters
#
# [*include_mechanisms*]
#   The optional nested "include-mechanisms" element contains a whitelist of allowed SASL mechanism names. No mechanisms will be allowed which are not present in this list.
#
# [*qop*]
#   The optional nested "qop" element contains a list of quality-of-protection values, in decreasing order of preference.
#
# [*reuse_session*]
#   The optional nested "reuse-session" boolean element specifies whether or not the server should attempt to reuse previously authenticated session information.  The mechanism may or may not support such reuse, and other factors may also prevent it.
#
# [*server_auth*]
#   The optional nested "server-auth" boolean element specifies whether the server should authenticate to the client.  Not all mechanisms may support this setting.
#
# [*strength*]
#   The optional nested "strength" element contains a list of cipher strength values, in decreasing order of preference.
#
#
define jboss_admin::resource::security (
  $server,
  $include_mechanisms             = undef,
  $qop                            = undef,
  $reuse_session                  = undef,
  $server_auth                    = undef,
  $strength                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $include_mechanisms != undef and $include_mechanisms != undefined and !is_array($include_mechanisms) {
      fail('The attribute include_mechanisms is not an array')
    }
    if $qop != undef and $qop != undefined and !is_array($qop) {
      fail('The attribute qop is not an array')
    }
    if $reuse_session != undef and $reuse_session != undefined {
      validate_bool($reuse_session)
    }
    if $server_auth != undef and $server_auth != undefined {
      validate_bool($server_auth)
    }
    if $strength != undef and $strength != undefined and !is_array($strength) {
      fail('The attribute strength is not an array')
    }

    $raw_options = {
      'include-mechanisms'           => $include_mechanisms,
      'qop'                          => $qop,
      'reuse-session'                => $reuse_session,
      'server-auth'                  => $server_auth,
      'strength'                     => $strength,
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
