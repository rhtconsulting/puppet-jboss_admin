# == Defines jboss_admin::constraint_vault_expression
#
# Configuration of whether vault expressions should be considered sensitive.
#
# === Parameters
#
# [*configured_requires_read*]
#   Set to override the default as to whether reading attributes containing vault expressions should be considered sensitive.
#
# [*configured_requires_write*]
#   Set to override the default as to whether writing attributes containing vault expressions should be considered sensitive.
#
# [*default_requires_read*]
#   Whether reading attributes containing vault expressions should be considered sensitive.
#
# [*default_requires_write*]
#   Whether writing attributes containing vault expressions should be considered sensitive.
#
#
define jboss_admin::resource::constraint_vault_expression (
  $server,
  $configured_requires_read       = undef,
  $configured_requires_write      = undef,
  $default_requires_read          = undef,
  $default_requires_write         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $configured_requires_read != undef and !is_bool($configured_requires_read) { 
      fail('The attribute configured_requires_read is not a boolean') 
    }
    if $configured_requires_write != undef and !is_bool($configured_requires_write) { 
      fail('The attribute configured_requires_write is not a boolean') 
    }
    if $default_requires_read != undef and !is_bool($default_requires_read) { 
      fail('The attribute default_requires_read is not a boolean') 
    }
    if $default_requires_write != undef and !is_bool($default_requires_write) { 
      fail('The attribute default_requires_write is not a boolean') 
    }
  

    $raw_options = { 
      'configured-requires-read'     => $configured_requires_read,
      'configured-requires-write'    => $configured_requires_write,
      'default-requires-read'        => $default_requires_read,
      'default-requires-write'       => $default_requires_write,
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
