jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_admin::datasource{'ExampleDS':
  ensure         => present,
  enabled        => true,
  connection_url => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
  driver_name    => h2,
  jndi_name      => 'java:jboss/datasources/ExampleDS',
  jta            => true,
  user_name      => sa,
  password       => sa,
  server         => main
}

