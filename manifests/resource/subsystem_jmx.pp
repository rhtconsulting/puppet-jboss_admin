# == Defines jboss_admin::subsystem_jmx
#
# The configuration of the JMX subsystem.
#
# === Parameters
#
# [*show_model*]
#   Set to 'true' to include MBeans for the model controller resources
#
#
define jboss_admin::resource::subsystem_jmx (
  $server,
  $show_model                     = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'show-model'                   => $show_model,
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
