jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_exec { 'Restart 1':
  command    => ':server-set-restart-required',
  server     => example
}
->jboss_admin::cleanup{'Cleanup 1':
  server     => example
}
->jboss_exec { 'Restart 2':
  command       => ':server-set-restart-required',
  server        => example
}

