# == Defines jboss_admin::subsystem_jsf
#
# The JSF subsystem
#
# === Parameters
#
# [*default_jsf_impl_slot*]
#   Default JSF implementation slot
#
#
define jboss_admin::resource::subsystem_jsf (
  $server,
  $default_jsf_impl_slot          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $default_jsf_impl_slot != undef and !is_string($default_jsf_impl_slot) { 
      fail('The attribute default_jsf_impl_slot is not a string') 
    }
  

    $raw_options = { 
      'default-jsf-impl-slot'        => $default_jsf_impl_slot,
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
