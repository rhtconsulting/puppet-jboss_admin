# == Defines jboss_admin::type_class-loading
#
# The management interface for the class loading system of the Java virtual machine.
#
# === Parameters
#
# [*verbose*]
#   Whether the verbose output for the class loading system is enabled.
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
#
define jboss_admin::resource::type_class-loading (
  $server,
  $verbose                        = undef,
  $object_name                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'verbose'                      => $verbose,
      'object-name'                  => $object_name,
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
