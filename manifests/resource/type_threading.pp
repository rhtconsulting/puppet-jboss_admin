# == Defines jboss_admin::type_threading
#
# The management interface for the thread system of the Java virtual machine.
#
# === Parameters
#
# [*all_thread_ids*]
#   All live thread IDs. If a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*current_thread_cpu_time_supported*]
#   Whether the Java virtual machine supports CPU time measurement for the current thread.
#
# [*object_monitor_usage_supported*]
#   Whether the Java virtual machine supports monitoring of object monitor usage.
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*synchronizer_usage_supported*]
#   Whether the Java virtual machine supports monitoring of ownable synchronizer usage.
#
# [*thread_contention_monitoring_enabled*]
#   Whether thread contention monitoring is enabled.
#
# [*thread_contention_monitoring_supported*]
#   Whether the Java virtual machine supports thread contention monitoring.
#
# [*thread_cpu_time_enabled*]
#   Whether thread CPU time measurement is enabled.
#
# [*thread_cpu_time_supported*]
#   Whether the Java virtual machine implementation supports CPU time measurement for any thread.
#
#
define jboss_admin::resource::type_threading (
  $server,
  $all_thread_ids                 = undef,
  $current_thread_cpu_time_supported = undef,
  $object_monitor_usage_supported = undef,
  $object_name                    = undef,
  $synchronizer_usage_supported   = undef,
  $thread_contention_monitoring_enabled = undef,
  $thread_contention_monitoring_supported = undef,
  $thread_cpu_time_enabled        = undef,
  $thread_cpu_time_supported      = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $all_thread_ids != undef and $all_thread_ids != undefined and !is_array($all_thread_ids) {
      fail('The attribute all_thread_ids is not an array')
    }
    if $current_thread_cpu_time_supported != undef and $current_thread_cpu_time_supported != undefined {
      validate_bool($current_thread_cpu_time_supported)
    }
    if $object_monitor_usage_supported != undef and $object_monitor_usage_supported != undefined {
      validate_bool($object_monitor_usage_supported)
    }
    if $synchronizer_usage_supported != undef and $synchronizer_usage_supported != undefined {
      validate_bool($synchronizer_usage_supported)
    }
    if $thread_contention_monitoring_enabled != undef and $thread_contention_monitoring_enabled != undefined {
      validate_bool($thread_contention_monitoring_enabled)
    }
    if $thread_contention_monitoring_supported != undef and $thread_contention_monitoring_supported != undefined {
      validate_bool($thread_contention_monitoring_supported)
    }
    if $thread_cpu_time_enabled != undef and $thread_cpu_time_enabled != undefined {
      validate_bool($thread_cpu_time_enabled)
    }
    if $thread_cpu_time_supported != undef and $thread_cpu_time_supported != undefined {
      validate_bool($thread_cpu_time_supported)
    }

    $raw_options = {
      'all-thread-ids'               => $all_thread_ids,
      'current-thread-cpu-time-supported' => $current_thread_cpu_time_supported,
      'object-monitor-usage-supported' => $object_monitor_usage_supported,
      'object-name'                  => $object_name,
      'synchronizer-usage-supported' => $synchronizer_usage_supported,
      'thread-contention-monitoring-enabled' => $thread_contention_monitoring_enabled,
      'thread-contention-monitoring-supported' => $thread_contention_monitoring_supported,
      'thread-cpu-time-enabled'      => $thread_cpu_time_enabled,
      'thread-cpu-time-supported'    => $thread_cpu_time_supported,
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
