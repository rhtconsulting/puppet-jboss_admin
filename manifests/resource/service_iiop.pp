# == Defines jboss_admin::service_iiop
#
# The IIOP service
#
# === Parameters
#
# [*enable_by_default*]
#   If this is true EJB's will be exposed over IIOP by default, otherwise it needs to be explicitly enabled in the deployment descriptor
#
# [*use_qualified_name*]
#   If true EJB names will be bound into the naming service with the application and module name prepended to the name (e.g. myapp/mymodule/MyEjb)
#
#
define jboss_admin::resource::service_iiop (
  $server,
  $enable_by_default              = undef,
  $use_qualified_name             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $enable_by_default != undef and !is_bool($enable_by_default) { 
      fail('The attribute enable_by_default is not a boolean') 
    }
    if $use_qualified_name != undef and !is_bool($use_qualified_name) { 
      fail('The attribute use_qualified_name is not a boolean') 
    }
  

    $raw_options = { 
      'enable-by-default'            => $enable_by_default,
      'use-qualified-name'           => $use_qualified_name,
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
