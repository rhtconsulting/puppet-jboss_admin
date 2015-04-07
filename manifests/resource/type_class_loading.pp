# == Defines jboss_admin::type_class_loading
#
# The management interface for the class loading system of the Java virtual machine.
#
# === Parameters
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*verbose*]
#   Whether the verbose output for the class loading system is enabled.
#
#
define jboss_admin::resource::type_class_loading (
  $server,
  $object_name                    = undef,
  $verbose                        = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $verbose != undef {
      validate_bool($verbose)
    }
  

    $raw_options = {
      'object-name'                  => $object_name,
      'verbose'                      => $verbose,
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
