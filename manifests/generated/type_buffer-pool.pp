# == Defines jboss_admin::type_buffer-pool
#
# Parent resource for the resources providing the management interface for the Java virtual machine's buffer pools.
#
# === Parameters
#
# [*name*]
#   The BufferPoolMXBean platform MBeans, organized by the value of the 'name' property in the MBean's ObjectName.
#
#
define jboss_admin::type_buffer-pool (
  $server,
  $name                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'name'                         => $name,
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
