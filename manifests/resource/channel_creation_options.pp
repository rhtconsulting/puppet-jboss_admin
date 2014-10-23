# == Defines jboss_admin::channel_creation_options
#
# The options that will be used during the EJB remote channel creation
#
# === Parameters
#
# [*type*]
#   The type of the channel creation option
#
# [*value*]
#   The value for the EJB remote channel creation option
#
#
define jboss_admin::resource::channel_creation_options (
  $server,
  $type                           = undef,
  $value                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $type != undef and !is_string($type) { 
      fail('The attribute type is not a string') 
    }
    if $type != undef and !($type in ['remoting','xnio']) {
      fail("The attribute type is not an allowed value: 'remoting','xnio'")
    }
    if $value != undef and !is_string($value) { 
      fail('The attribute value is not a string') 
    }
  

    $raw_options = { 
      'type'                         => $type,
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
