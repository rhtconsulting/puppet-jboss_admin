define jboss_admin::cleanup(
  $server
) {
  jboss_exec{"Reload Server $name":
    command => ":reload",
    onlyif  => "(response-headers.process-state == reload-required) of :whoami",
    notify  => Jboss_exec["Check Server Up After $name"],
    server  => $server
  }
  ->
  jboss_exec{"Restart Server $name":
    command => ":shutdown(restart=true)",
    onlyif  => "(response-headers.process-state == restart-required) of :whoami",
    notify  => Jboss_exec["Check Server Up After $name"],
    server  => $server
  }

  jboss_exec{"Check Server Up After $name":
    command     => ':read-attribute(name=server-state)',
    refreshonly => true,
    tries       => 10,
    try_sleep   => 1,
    server      => $server
  }

}
