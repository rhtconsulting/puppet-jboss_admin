# == Defines jboss_admin::security_domain
#
# Configures a security domain. Authentication, authorization, ACL, mapping, auditing and identity trust are configured here.
#
# === Parameters
#
# [*cache_type*]
#   Adds a cache to speed up authentication checks. Allowed values are 'default' to use simple map as the cache and 'infinispan' to use an Infinispan cache.
#
#
define jboss_admin::resource::security_domain (
  $server,
  $cache_type                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $cache_type != undef and !is_string($cache_type) { 
      fail('The attribute cache_type is not a string') 
    }
  

    $raw_options = { 
      'cache-type'                   => $cache_type,
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
