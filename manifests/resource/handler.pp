# == Defines jboss_admin::handler
#
# Endpoint handler
#
# === Parameters
#
# [*class*]
#   Handler class
#
#
define jboss_admin::resource::handler (
  $server,
  $class                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $class != undef and !is_string($class) { 
      fail('The attribute class is not a string') 
    }
  

    $raw_options = { 
      'class'                        => $class,
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
