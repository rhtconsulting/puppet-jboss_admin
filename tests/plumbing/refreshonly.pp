jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_exec { 'Should Not Execute':
  command     => ':whoami',
  refreshonly => true,
  server      => main
}

notify { 'Generating notification': }
~> jboss_exec { 'Should Execute':
  command     => ':read-resource',
  refreshonly => true,
  server      => main,
  loglevel    => info,
  logoutput   => true
}

