# == Defines jboss_admin::subsystem_web
#
# The configuration of the jboss.web subsystem.
#
# === Parameters
#
# [*native*]
#   Add the native initialization listener to the web container.
#
# [*default_virtual_server*]
#   The web container's default virtual server.
#
# [*instance_id*]
#   Set the identifier for this server instance.
#
#
define jboss_admin::resource::subsystem_web (
  $server,
  $native                         = undef,
  $default_virtual_server         = undef,
  $instance_id                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'native'                       => $native,
      'default-virtual-server'       => $default_virtual_server,
      'instance-id'                  => $instance_id,
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
