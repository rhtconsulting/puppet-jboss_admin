# == Defines jboss_admin::service_async
#
# The EJB3 Asynchronous Invocation Service
#
# === Parameters
#
# [*thread_pool_name*]
#   The name of the thread pool which handles asynchronous invocations
#
#
define jboss_admin::resource::service_async (
  $server,
  $thread_pool_name               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $thread_pool_name != undef and !is_string($thread_pool_name) { 
      fail('The attribute thread_pool_name is not a string') 
    }
  

    $raw_options = { 
      'thread-pool-name'             => $thread_pool_name,
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
