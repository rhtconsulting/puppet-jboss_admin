jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_batch {'Create ExampleDS':
  server => main,
  batch  => [
    { 
      address => '/subsystem=datasources/data-source=ExampleDS',
      ensure  => present,
      options => {
        'connection-url' => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
        'driver-name'    => 'h2',
        'jndi-name'      => 'java:jboss/datasources/ExampleDS2',
        'jta'            => true,
        'user-name'      => 'sa',
        'password'       => 'sa'
      }
    },
    {
      command => '/subsystem=datasources/data-source=ExampleDS:enable'
    }
  ]
}

