# == Defines jboss_admin::subsystem_remoting
#
# The configuration of the Remoting subsystem.
#
# === Parameters
#
# [*worker_read_threads*]
#   The number of read threads to create for the remoting worker.
#
# [*worker_task_core_threads*]
#   The number of core threads for the remoting worker task thread pool.
#
# [*worker_task_keepalive*]
#   The number of milliseconds to keep non-core remoting worker task threads alive.
#
# [*worker_task_limit*]
#   The maximum number of remoting worker tasks to allow before rejecting.
#
# [*worker_task_max_threads*]
#   The maximum number of threads for the remoting worker task thread pool.
#
# [*worker_write_threads*]
#   The number of write threads to create for the remoting worker.
#
#
define jboss_admin::resource::subsystem_remoting (
  $server,
  $worker_read_threads            = undef,
  $worker_task_core_threads       = undef,
  $worker_task_keepalive          = undef,
  $worker_task_limit              = undef,
  $worker_task_max_threads        = undef,
  $worker_write_threads           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $worker_read_threads != undef and $worker_read_threads != undefined and !is_integer($worker_read_threads) {
      fail('The attribute worker_read_threads is not an integer')
    }
    if $worker_task_core_threads != undef and $worker_task_core_threads != undefined and !is_integer($worker_task_core_threads) {
      fail('The attribute worker_task_core_threads is not an integer')
    }
    if $worker_task_keepalive != undef and $worker_task_keepalive != undefined and !is_integer($worker_task_keepalive) {
      fail('The attribute worker_task_keepalive is not an integer')
    }
    if $worker_task_limit != undef and $worker_task_limit != undefined and !is_integer($worker_task_limit) {
      fail('The attribute worker_task_limit is not an integer')
    }
    if $worker_task_max_threads != undef and $worker_task_max_threads != undefined and !is_integer($worker_task_max_threads) {
      fail('The attribute worker_task_max_threads is not an integer')
    }
    if $worker_write_threads != undef and $worker_write_threads != undefined and !is_integer($worker_write_threads) {
      fail('The attribute worker_write_threads is not an integer')
    }
  

    $raw_options = {
      'worker-read-threads'          => $worker_read_threads,
      'worker-task-core-threads'     => $worker_task_core_threads,
      'worker-task-keepalive'        => $worker_task_keepalive,
      'worker-task-limit'            => $worker_task_limit,
      'worker-task-max-threads'      => $worker_task_max_threads,
      'worker-write-threads'         => $worker_write_threads,
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
