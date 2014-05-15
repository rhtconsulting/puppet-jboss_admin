# == Defines jboss_admin::type_memory
#
# The management interface for the memory system of the Java virtual machine.
#
# === Parameters
#
# [*verbose*]
#   Whether verbose output for the memory system is enabled.
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
#
define jboss_admin::resource::type_memory (
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
