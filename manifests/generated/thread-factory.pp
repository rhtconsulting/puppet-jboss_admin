# == Defines jboss_admin::thread-factory
#
# A thread factory (implementing java.util.concurrent.ThreadFactory).
#
# === Parameters
#
# [*thread_name_pattern*]
#   The template used to create names for threads.  The following patterns may be used:
	%% - emit a percent sign
	%t - emit the per-factory thread sequence number
	%g - emit the global thread sequence number
	%f - emit the factory sequence number
	%i - emit the thread ID.
#
# [*group_name*]
#   Specifies the name of a  thread group to create for this thread factory.
#
# [*name*]
#   The name of the created thread factory.
#
# [*priority*]
#   May be used to specify the thread priority of created threads.
#
#
define jboss_admin::thread-factory (
  $server,
  $thread_name_pattern            = undef,
  $group_name                     = undef,
  $name                           = undef,
  $priority                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $priority != undef && !is_integer($priority) { 
      fail('The attribute priority is not an integer') 
    }
  

    $raw_options = { 
      'thread-name-pattern'          => $thread_name_pattern,
      'group-name'                   => $group_name,
      'name'                         => $name,
      'priority'                     => $priority,
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
