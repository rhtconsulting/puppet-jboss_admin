# == Defines jboss_admin::sso
#
# The SSO configuration for this virtual server.
#
# === Parameters
#
# [*cache_container*]
#   Enables clustered SSO using the specified clustered cache container.
#
# [*reauthenticate*]
#   Enables reauthentication with the realm when using SSO.
#
# [*domain*]
#   The cookie domain that will be used.
#
# [*cache_name*]
#   Name of the cache to use in the cache container.
#
#
define jboss_admin::resource::sso (
  $server,
  $cache_container                = undef,
  $reauthenticate                 = undef,
  $domain                         = undef,
  $cache_name                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'cache-container'              => $cache_container,
      'reauthenticate'               => $reauthenticate,
      'domain'                       => $domain,
      'cache-name'                   => $cache_name,
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
