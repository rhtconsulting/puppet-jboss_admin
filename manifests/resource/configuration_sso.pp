# == Defines jboss_admin::configuration_sso
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
define jboss_admin::resource::configuration_sso (
  $server,
  $cache_container                = undef,
  $cache_name                     = undef,
  $domain                         = undef,
  $reauthenticate                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $cache_container != undef and !is_string($cache_container) { 
      fail('The attribute cache_container is not a string') 
    }
    if $cache_name != undef and !is_string($cache_name) { 
      fail('The attribute cache_name is not a string') 
    }
    if $domain != undef and !is_string($domain) { 
      fail('The attribute domain is not a string') 
    }
    if $reauthenticate != undef { 
      validate_bool($reauthenticate)
    }
  

    $raw_options = { 
      'cache-container'              => $cache_container,
      'cache-name'                   => $cache_name,
      'domain'                       => $domain,
      'reauthenticate'               => $reauthenticate,
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
