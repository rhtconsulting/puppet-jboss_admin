# == Defines jboss_admin::applies_to
#
# Information about the resources, attributes and operations to which an access control constraint applies.
#
# === Parameters
#
# [*address*]
#   Address pattern describing a resource or resources to which the constraint applies.
#
# [*attributes*]
#   List of the names of attributes to which the constraint specifically applies.
#
# [*entire_resource*]
#   True if the constraint applies to the resource as a whole; false if it only applies to one or more attributes or operations.
#
# [*operations*]
#   List of the names of operations to which the constraint specifically applies.
#
#
define jboss_admin::resource::applies_to (
  $server,
  $address                        = undef,
  $attributes                     = undef,
  $entire_resource                = undef,
  $operations                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $attributes != undef and !is_array($attributes) {
      fail('The attribute attributes is not an array')
    }
    if $entire_resource != undef {
      validate_bool($entire_resource)
    }
    if $operations != undef and !is_array($operations) {
      fail('The attribute operations is not an array')
    }
  

    $raw_options = {
      'address'                      => $address,
      'attributes'                   => $attributes,
      'entire-resource'              => $entire_resource,
      'operations'                   => $operations,
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
