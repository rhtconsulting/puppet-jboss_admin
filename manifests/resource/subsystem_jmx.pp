# == Defines jboss_admin::subsystem_jmx
#
# The configuration of the JMX subsystem.
#
# === Parameters
#
# [*non_core_mbean_sensitivity*]
#   Whether or not core MBeans, i.e. mbeans not coming from the model controller, should be considered sensitive.
#
# [*show_model*]
#   Alias for the existance of the 'resolved' model controller jmx facade. When writing, if set to 'true' it will add the 'resolved' model controller jmx facade resource with the default domain name.
#
#
define jboss_admin::resource::subsystem_jmx (
  $server,
  $non_core_mbean_sensitivity     = undef,
  $show_model                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $non_core_mbean_sensitivity != undef {
      validate_bool($non_core_mbean_sensitivity)
    }
    if $show_model != undef {
      validate_bool($show_model)
    }
  

    $raw_options = {
      'non-core-mbean-sensitivity'   => $non_core_mbean_sensitivity,
      'show-model'                   => $show_model,
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
