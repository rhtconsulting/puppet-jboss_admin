# == Defines jboss_admin::load_metric
#
# Load metric definition
#
# === Parameters
#
# [*capacity*]
#   Capacity of the metric.
#
# [*property*]
#   Properties for the metric.
#
# [*type*]
#   Type of the metric
#
# [*weight*]
#   Weight of the metric.
#
#
define jboss_admin::resource::load_metric (
  $server,
  $capacity                       = undef,
  $property                       = undef,
  $type                           = undef,
  $weight                         = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $type != undef and !($type in ['cpu','mem','heap','sessions','receive-traffic','send-traffic','requests','busyness']) {
      fail("The attribute type is not an allowed value: 'cpu','mem','heap','sessions','receive-traffic','send-traffic','requests','busyness'")
    }
    if $weight != undef and !is_integer($weight) { 
      fail('The attribute weight is not an integer') 
    }
  

    $raw_options = { 
      'capacity'                     => $capacity,
      'property'                     => $property,
      'type'                         => $type,
      'weight'                       => $weight,
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
