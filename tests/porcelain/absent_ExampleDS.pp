jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_admin::resource::data_source{'/subsystem=datasources/data-source=ExampleDS':
  ensure         => absent,
  server         => main
}

