# == Defines jboss_admin::authorization_plug_in
#
# Configuration of a user store plug-in for use by the realm.
#
# === Parameters
#
# [*resource_name*]
#   The short name of the plug-in (as registered) to use.
#
#
define jboss_admin::resource::authorization_plug_in (
  $server,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
  

    $raw_options = { 
      'name'                         => $resource_name,
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
