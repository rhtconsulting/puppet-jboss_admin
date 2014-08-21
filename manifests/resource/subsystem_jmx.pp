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
  $path                           = $name
) {
  if $ensure == present {

    if $non_core_mbean_sensitivity != undef and !is_bool($non_core_mbean_sensitivity) { 
      fail('The attribute non_core_mbean_sensitivity is not a boolean') 
    }
    if $show_model != undef and !is_bool($show_model) { 
      fail('The attribute show_model is not a boolean') 
    }
  

    $raw_options = { 
      'non-core-mbean-sensitivity'   => $non_core_mbean_sensitivity,
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
