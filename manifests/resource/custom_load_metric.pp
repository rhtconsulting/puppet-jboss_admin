# == Defines jboss_admin::custom_load_metric
#
# Load metric definition
#
# === Parameters
#
# [*capacity*]
#   Capacity of the metric.
#
# [*class*]
#   Class name of the custom metric.
#
# [*property*]
#   Properties for the metric.
#
# [*weight*]
#   Weight of the metric.
#
#
define jboss_admin::resource::custom_load_metric (
  $server,
  $capacity                       = undef,
  $class                          = undef,
  $property                       = undef,
  $weight                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $class != undef and !is_string($class) { 
      fail('The attribute class is not a string') 
    }
    if $weight != undef and !is_integer($weight) { 
      fail('The attribute weight is not an integer') 
    }
  

    $raw_options = { 
      'capacity'                     => $capacity,
      'class'                        => $class,
      'property'                     => $property,
      'weight'                       => $weight,
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
