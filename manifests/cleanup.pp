define jboss_admin::cleanup(
  $server = $name
) {
  jboss_exec{"Restart Server $name":
    command => "/:shutdown(restart=true)",
    onlyif  => "(response-headers.process-state == restart-required) of :whoami",
    server  => $server
  }

  jboss_exec{"Reload Server $name":
    command => "/:reload",
    onlyif  => "(response-headers.process-state == reload-required) of :whoami",
    server  => $server
  }

  Jboss_resource<| server == $name |> -> Jboss_exec["Reload Server $name"] -> Jboss_exec["Restart Server $name"]
  Jboss_exec<| server == $name and title != "Restart Server $name" and title != "Reload Server $name"|> -> Jboss_exec["Reload Server $name"] -> Jboss_exec["Restart Server $name"]
}
