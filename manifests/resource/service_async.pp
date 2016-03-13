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
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'thread-pool-name'             => $thread_pool_name,
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
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }
}
