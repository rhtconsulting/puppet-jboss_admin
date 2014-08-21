# == Defines jboss_admin::type_memory
#
# The management interface for the memory system of the Java virtual machine.
#
# === Parameters
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*verbose*]
#   Whether verbose output for the memory system is enabled.
#
#
define jboss_admin::resource::type_memory (
  $server,
  $object_name                    = undef,
  $verbose                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $object_name != undef and !is_string($object_name) { 
      fail('The attribute object_name is not a string') 
    }
    if $verbose != undef and !is_bool($verbose) { 
      fail('The attribute verbose is not a boolean') 
    }
  

    $raw_options = { 
      'object-name'                  => $object_name,
      'verbose'                      => $verbose,
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
