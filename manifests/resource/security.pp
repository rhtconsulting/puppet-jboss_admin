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
# [*server_auth*]
#   The optional nested "server-auth" boolean element specifies whether the server should authenticate to the client.  Not all mechanisms may support this setting.
#
# [*strength*]
#   The optional nested "strength" element contains a list of cipher strength values, in decreasing order of preference.
#
# [*reuse_session*]
#   The optional nested "reuse-session" boolean element specifies whether or not the server should attempt to reuse previously authenticated session information.  The mechanism may or may not support such reuse, and other factors may also prevent it.
#
#
define jboss_admin::resource::security (
  $server,
  $include_mechanisms             = undef,
  $qop                            = undef,
  $server_auth                    = undef,
  $strength                       = undef,
  $reuse_session                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'include-mechanisms'           => $include_mechanisms,
      'qop'                          => $qop,
      'server-auth'                  => $server_auth,
      'strength'                     => $strength,
      'reuse-session'                => $reuse_session,
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
