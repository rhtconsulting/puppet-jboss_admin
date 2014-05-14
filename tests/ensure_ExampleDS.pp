jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_resource {'/subsystem=datasources/data-source=ExampleDS':
  ensure => present,
  options => {
    'connection-url' => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
    'driver-name'    => 'h2',
    'jndi-name'      => 'java:jboss/datasources/ExampleDS',
    'jta'            => true,
    'user-name'      => 'sa',
    'password'       => 'sa'
  },
  server => Jboss_admin::Server['main']
}
