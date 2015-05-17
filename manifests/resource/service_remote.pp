# == Defines jboss_admin::service_remote
#
# The EJB3 Remote Service
#
# === Parameters
#
# [*connector_ref*]
#   The name of the connector on which the EJB3 remoting channel is registered
#
# [*thread_pool_name*]
#   The name of the thread pool that handles remote invocations
#
#
define jboss_admin::resource::service_remote (
  $server,
  $connector_ref                  = undef,
  $thread_pool_name               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {


    $raw_options = {
      'connector-ref'                => $connector_ref,
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
