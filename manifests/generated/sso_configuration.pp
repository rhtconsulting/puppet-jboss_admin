# == Defines jboss_admin::sso_configuration
#
# The SSO configuration for this virtual server.
#
# === Parameters
#
# [*domain*]
#   The cookie domain that will be used.
#
# [*cache_name*]
#   Name of the cache to use in the cache container.
#
# [*cache_container*]
#   Enables clustered SSO using the specified clustered cache container.
#
# [*reauthenticate*]
#   Enables reauthentication with the realm when using SSO.
#
#
define jboss_admin::sso_configuration (
  $server,
  $domain                         = undef,
  $cache_name                     = undef,
  $cache_container                = undef,
  $reauthenticate                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'domain'                       => $domain,
      'cache-name'                   => $cache_name,
      'cache-container'              => $cache_container,
      'reauthenticate'               => $reauthenticate,
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
