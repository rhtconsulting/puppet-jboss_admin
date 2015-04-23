define jboss_admin::cleanup(
  $server,
  $wait_for_up_tries     = 10,
  $wait_for_up_try_sleep = 1,
  $noop                  = false,
) {
  jboss_exec{"Reload Server ${name}":
    command => ':reload',
    onlyif  => '(response-headers.process-state == reload-required) of :whoami',
    notify  => Jboss_exec["Check Server Up After ${name}"],
    server  => $server,
    noop    => $noop,
  }
  ->
  jboss_exec{"Restart Server ${name}":
    command => ':shutdown(restart=true)',
    onlyif  => '(response-headers.process-state == restart-required) of :whoami',
    notify  => Jboss_exec["Check Server Up After ${name}"],
    server  => $server,
    noop    => $noop,
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
