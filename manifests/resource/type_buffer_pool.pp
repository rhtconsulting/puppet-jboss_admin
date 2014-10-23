# == Defines jboss_admin::type_buffer_pool
#
# The management interface for a buffer pool, for example a pool of direct or mapped buffers.
#
# === Parameters
#
# [*resource_name*]
#   The name representing this buffer pool.
#
#
define jboss_admin::resource::type_buffer_pool (
  $server,
  $resource_name                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
  

    $raw_options = { 
      'name'                         => $resource_name,
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
