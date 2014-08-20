# == Defines jboss_admin::subsystem_jgroups
#
# The configuration of the JGroups subsystem.
#
# === Parameters
#
# [*default_stack*]
#   The default JGroups protocol stack.
#
#
define jboss_admin::resource::subsystem_jgroups (
  $server,
  $default_stack                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'default-stack'                => $default_stack,
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
