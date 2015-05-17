jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_resource {'/subsystem=datasources/data-source=ExampleDS':
  ensure  => present,
  options => {
    'connection-url' => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
    'driver-name'    => 'h2',
    'jndi-name'      => 'java:jboss/datasources/ExampleDS2',
    'jta'            => true,
    'user-name'      => 'sa',
    'password'       => 'sa'
  },
  server  => main
}
->
jboss_exec {'Enable Data Source':
  command => '/subsystem=datasources/data-source=ExampleDS:enable',
  onlyif  => '(result == false) of /subsystem=datasources/data-source=ExampleDS:read-attribute(name=enabled)',
  server  => main
}

jboss_resource{'/core-service=management/management-interface=http-interface':
  ensure => absent,
  server => main
}

jboss_resource{'/subsystem=deployment-scanner/scanner=default':
  ensure  => present,
  options => {
    'scan-enabled'  => true,
    'scan-interval' => 4000
  },
  server  => main
}
