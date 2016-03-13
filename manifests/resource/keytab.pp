# == Defines jboss_admin::keytab
#
# Configuration of a keytab to use to represent a server or host controllers identity.
#
# === Parameters
#
# [*debug*]
#   Should additional debug logging be enabled during TGT acquisition?
#
# [*for_hosts*]
#   A server can be accessed using different host names, this attribute specifies which host names this keytab can be used with.
#
# [*path*]
#   The path to the keytab.
#
# [*relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute.
#
#
define jboss_admin::resource::keytab (
  $server,
  $debug                          = undef,
  $for_hosts                      = undef,
  $path                           = undef,
  $relative_to                    = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $debug != undef and $debug != undefined {
      validate_bool($debug)
    }
    if $for_hosts != undef and $for_hosts != undefined and !is_array($for_hosts) {
      fail('The attribute for_hosts is not an array')
    }

    $raw_options = {
      'debug'                        => $debug,
      'for-hosts'                    => $for_hosts,
      'path'                         => $path,
      'relative-to'                  => $relative_to,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
