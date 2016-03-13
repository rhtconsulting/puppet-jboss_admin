# == Defines jboss_admin::thread_factory
#
# A thread factory (implementing java.util.concurrent.ThreadFactory).
#
# === Parameters
#
# [*group_name*]
#   Specifies the name of a  thread group to create for this thread factory.
#
# [*resource_name*]
#   The name of the created thread factory.
#
# [*priority*]
#   May be used to specify the thread priority of created threads.
#
# [*thread_name_pattern*]
#   The template used to create names for threads.  The following patterns may be used:
#       %% - emit a percent sign
#       %t - emit the per-factory thread sequence number
#       %g - emit the global thread sequence number
#       %f - emit the factory sequence number
#       %i - emit the thread ID.
#
#
define jboss_admin::resource::thread_factory (
  $server,
  $group_name                     = undef,
  $resource_name                  = undef,
  $priority                       = undef,
  $thread_name_pattern            = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $priority != undef and $priority != undefined and !is_integer($priority) {
      fail('The attribute priority is not an integer')
    }

    $raw_options = {
      'group-name'                   => $group_name,
      'name'                         => $resource_name,
      'priority'                     => $priority,
      'thread-name-pattern'          => $thread_name_pattern,
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
