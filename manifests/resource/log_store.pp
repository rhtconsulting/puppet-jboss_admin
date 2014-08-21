# == Defines jboss_admin::log_store
#
# Representation of the transaction logging storage mechanism.
#
# === Parameters
#
# [*type*]
#   Specifies the implementation type of the logging store.
#
#
define jboss_admin::resource::log_store (
  $server,
  $type                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $type != undef and !is_string($type) { 
      fail('The attribute type is not a string') 
    }
  

    $raw_options = { 
      'type'                         => $type,
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
