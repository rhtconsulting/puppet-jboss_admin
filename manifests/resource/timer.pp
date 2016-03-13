# == Defines jboss_admin::timer
#
# Actual timer running for EJB
#
# === Parameters
#
# [*active*]
#   Indicates whether this timer is active or suspended.
#
# [*calendar_timer*]
#   Whether this timer is a calendar-based timer, or "undefined" if the timer has expired or been cancelled.
#
# [*info*]
#   Serializable information associated with timer.
#
# [*next_timeout*]
#   The point in time (in ms since the epoch) at which the next timer expiration is scheduled to occur, or "undefined" if the timer has no future timeouts, is expired, or has been cancelled.
#
# [*persistent*]
#   Whether this timer has persistent semantics or "undefined" if the timer has expired or been cancelled.
#
# [*primary_key*]
#   Primary key of EJB instance which started the timer.
#
# [*schedule*]
#   The schedule expression corresponding to this timer or "undefined" if the timer was not created using a schedule expression, is expired, or has been cancelled.
#
# [*time_remaining*]
#   The number of milliseconds that will elapse before the next scheduled timer expiration, or "undefined" if the timer has no future timeouts, is expired, or has been cancelled.
#
#
define jboss_admin::resource::timer (
  $server,
  $active                         = undef,
  $calendar_timer                 = undef,
  $info                           = undef,
  $next_timeout                   = undef,
  $persistent                     = undef,
  $primary_key                    = undef,
  $schedule                       = undef,
  $time_remaining                 = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $active != undef and $active != undefined {
      validate_bool($active)
    }
    if $calendar_timer != undef and $calendar_timer != undefined {
      validate_bool($calendar_timer)
    }
    if $next_timeout != undef and $next_timeout != undefined and !is_integer($next_timeout) {
      fail('The attribute next_timeout is not an integer')
    }
    if $persistent != undef and $persistent != undefined {
      validate_bool($persistent)
    }
    if $schedule != undef and $schedule != undefined and !is_array($schedule) {
      fail('The attribute schedule is not an array')
    }
    if $time_remaining != undef and $time_remaining != undefined and !is_integer($time_remaining) {
      fail('The attribute time_remaining is not an integer')
    }

    $raw_options = {
      'active'                       => $active,
      'calendar-timer'               => $calendar_timer,
      'info'                         => $info,
      'next-timeout'                 => $next_timeout,
      'persistent'                   => $persistent,
      'primary-key'                  => $primary_key,
      'schedule'                     => $schedule,
      'time-remaining'               => $time_remaining,
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
