# == Defines jboss_admin::binding
#
# JNDI bindings for primitive types
#
# === Parameters
#
# [*type*]
#   The type of the value to bind for simple bindings, this must be a primitive type
#
# [*module*]
#   The module to load the object factory from for object factory bindings
#
# [*binding_type*]
#   The type of binding to create, may be simple, lookup or object-factory
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
#
define jboss_admin::resource::binding (
  $server,
  $type                           = undef,
  $module                         = undef,
  $binding_type                   = undef,
  $value                          = undef,
  $class                          = undef,
  $lookup                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'type'                         => $type,
      'module'                       => $module,
      'binding-type'                 => $binding_type,
      'value'                        => $value,
      'class'                        => $class,
      'lookup'                       => $lookup,
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
