# == Defines jboss_admin::type_threading
#
# The management interface for the thread system of the Java virtual machine.
#
# === Parameters
#
# [*object_monitor_usage_supported*]
#   Whether the Java virtual machine supports monitoring of object monitor usage.
#
# [*thread_cpu_time_enabled*]
#   Whether thread CPU time measurement is enabled.
#
# [*synchronizer_usage_supported*]
#   Whether the Java virtual machine supports monitoring of ownable synchronizer usage.
#
# [*all_thread_ids*]
#   All live thread IDs. If a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*thread_contention_monitoring_supported*]
#   Whether the Java virtual machine supports thread contention monitoring.
#
# [*thread_cpu_time_supported*]
#   Whether the Java virtual machine implementation supports CPU time measurement for any thread.
#
# [*current_thread_cpu_time_supported*]
#   Whether the Java virtual machine supports CPU time measurement for the current thread.
#
# [*thread_contention_monitoring_enabled*]
#   Whether thread contention monitoring is enabled.
#
#
define jboss_admin::type_threading (
  $server,
  $object_monitor_usage_supported = undef,
  $thread_cpu_time_enabled        = undef,
  $synchronizer_usage_supported   = undef,
  $all_thread_ids                 = undef,
  $object_name                    = undef,
  $thread_contention_monitoring_supported = undef,
  $thread_cpu_time_supported      = undef,
  $current_thread_cpu_time_supported = undef,
  $thread_contention_monitoring_enabled = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'object-monitor-usage-supported' => $object_monitor_usage_supported,
      'thread-cpu-time-enabled'      => $thread_cpu_time_enabled,
      'synchronizer-usage-supported' => $synchronizer_usage_supported,
      'all-thread-ids'               => $all_thread_ids,
      'object-name'                  => $object_name,
      'thread-contention-monitoring-supported' => $thread_contention_monitoring_supported,
      'thread-cpu-time-supported'    => $thread_cpu_time_supported,
      'current-thread-cpu-time-supported' => $current_thread_cpu_time_supported,
      'thread-contention-monitoring-enabled' => $thread_contention_monitoring_enabled,
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
