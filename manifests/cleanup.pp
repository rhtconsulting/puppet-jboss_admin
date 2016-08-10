# == Define Jboss_admin::Cleanup
#
# Reloads or restarts the jboss container if needed.
#
# @param server                               jboss_admin::server to cleanup
# @param wait_for_up_tries                    Number of attempts to try for JBoss EAP to be back up after a
#                                             reload or restart.
# @param wait_for_up_try_sleep                Seconds to wait between checks for JBoss EAP to be back up after a
#                                             reload or restart.
# @param wait_for_reload_or_restart_tries     If reload or restart is required, number of attempts to to try to
#                                             perform reload or restart of JBoss EAP.
# @param wait_for_reload_or_restart_try_sleep If reload or restart is required, seconds to wait between attempts.
define jboss_admin::cleanup(
  $server,
  $wait_for_up_tries                    = 10,
  $wait_for_up_try_sleep                = 1,
  $wait_for_reload_or_restart_tries     = 10,
  $wait_for_reload_or_restart_try_sleep = 1,
  $noop                                 = false,
) {
  jboss_exec{"Reload Server ${name}":
    command   => ':reload',
    onlyif    => '(response-headers.process-state == reload-required) of :whoami',
    tries     => $wait_for_reload_or_restart_tries,
    try_sleep => $wait_for_reload_or_restart_try_sleep,
    notify    => Jboss_exec["Check Server Up After ${name}"],
    server    => $server,
    noop      => $noop,
  }
  ->
  jboss_exec{"Restart Server ${name}":
    command   => ':shutdown(restart=true)',
    onlyif    => '(response-headers.process-state == restart-required) of :whoami',
    tries     => $wait_for_reload_or_restart_tries,
    try_sleep => $wait_for_reload_or_restart_try_sleep,
    notify    => Jboss_exec["Check Server Up After ${name}"],
    server    => $server,
    noop      => $noop,
  }
  ->
  jboss_exec{"Check Server Up After ${name}":
    command         => ':read-attribute(name=server-state)',
    expected_output => {  'outcome' => 'success',
                          'result'  => 'running',},
    refreshonly     => true,
    tries           => $wait_for_up_tries,
    try_sleep       => $wait_for_up_try_sleep,
    server          => $server,
    noop            => $noop,
  }
}
