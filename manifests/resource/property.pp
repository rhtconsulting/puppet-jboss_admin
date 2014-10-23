# == Defines jboss_admin::property
#
# Properties supported by the underlying provider. The property name is inferred from the last element of the properties address.
#
# === Parameters
#
# [*value*]
#   The property value.
#
#
define jboss_admin::resource::property (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $value != undef and !is_string($value) { 
      fail('The attribute value is not a string') 
    }
  

    $raw_options = { 
      'value'                        => $value,
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
