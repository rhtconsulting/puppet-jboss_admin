jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_admin::datasource{'ExampleDS':
  ensure         => absent,
  server         => main
}

