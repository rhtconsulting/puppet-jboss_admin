jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_resource {'/subsystem=datasources/data-source=ExampleDS':
  ensure => absent,
  server => Jboss_admin::Server['main']
}
