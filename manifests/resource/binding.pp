# == Defines jboss_admin::binding
#
# JNDI bindings for primitive types
#
# === Parameters
#
# [*binding_type*]
#   The type of binding to create, may be simple, lookup or object-factory
#
# [*type*]
#   The type of the value to bind for simple bindings, this must be a primitive type
#
# [*value*]
#   The value to bind for simple bindings
#
# [*class*]
#   The object factory class name for object factory bindings
#
# [*lookup*]
#   The entry to lookup in JNDI for lookup bindings
#
# [*module*]
#   The module to load the object factory from for object factory bindings
#
#
define jboss_admin::resource::binding (
  $server,
  $binding_type                   = undef,
  $type                           = undef,
  $value                          = undef,
  $class                          = undef,
  $lookup                         = undef,
  $module                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'binding-type'                 => $binding_type,
      'type'                         => $type,
      'value'                        => $value,
      'class'                        => $class,
      'lookup'                       => $lookup,
      'module'                       => $module,
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
