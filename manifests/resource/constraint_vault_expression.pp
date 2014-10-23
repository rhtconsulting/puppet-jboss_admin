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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $configured_requires_read != undef { 
      validate_bool($configured_requires_read)
    }
    if $configured_requires_write != undef { 
      validate_bool($configured_requires_write)
    }
    if $default_requires_read != undef { 
      validate_bool($default_requires_read)
    }
    if $default_requires_write != undef { 
      validate_bool($default_requires_write)
    }
  

    $raw_options = { 
      'configured-requires-read'     => $configured_requires_read,
      'configured-requires-write'    => $configured_requires_write,
      'default-requires-read'        => $default_requires_read,
      'default-requires-write'       => $default_requires_write,
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
