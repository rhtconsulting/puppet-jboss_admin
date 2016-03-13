# == Defines jboss_admin::subsystem_web
#
# The configuration of the jboss.web subsystem.
#
# === Parameters
#
# [*default_virtual_server*]
#   The web container's default virtual server.
#
# [*instance_id*]
#   Set the identifier for this server instance.
#
# [*native*]
#   Add the native initialization listener to the web container.
#
#
define jboss_admin::resource::subsystem_web (
  $server,
  $default_virtual_server         = undef,
  $instance_id                    = undef,
  $native                         = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {
    $raw_options = {
      'default-virtual-server'       => $default_virtual_server,
      'instance-id'                  => $instance_id,
      'native'                       => $native,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server
    }
  }
}
