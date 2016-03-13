# == Defines jboss_admin::sso
#
# The SSO configuration for this virtual server.
#
# === Parameters
#
# [*cache_container*]
#   Enables clustered SSO using the specified clustered cache container.
#
# [*cache_name*]
#   Name of the cache to use in the cache container.
#
# [*domain*]
#   The cookie domain that will be used.
#
# [*reauthenticate*]
#   Enables reauthentication with the realm when using SSO.
#
#
define jboss_admin::resource::sso (
  $server,
  $cache_container                = undef,
  $cache_name                     = undef,
  $domain                         = undef,
  $reauthenticate                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {
    $raw_options = {
      'cache-container'              => $cache_container,
      'cache-name'                   => $cache_name,
      'domain'                       => $domain,
      'reauthenticate'               => $reauthenticate,
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
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server
    }
  }
}
