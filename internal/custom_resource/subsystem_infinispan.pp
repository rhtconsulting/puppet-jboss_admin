# == Defines jboss_admin::subsystem_infinispan
#
# The configuration of the infinispan subsystem
#
# === Parameters
#
# [*default_cache_container*]
#   The default infinispan cache container name
#
#
define jboss_admin::resource::subsystem_infinispan (
  $server,
  $default_cache_container        = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {
    $raw_options = {
      'default-cache-container'      => $default_cache_container,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server
    }
  }
}
