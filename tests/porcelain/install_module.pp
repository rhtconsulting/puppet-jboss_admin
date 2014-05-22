jboss_admin::server{ 'standalone':
  base_path => '/opt/jboss'
}

jboss_admin::module{ 'com.mysql':
  ensure        => present,
  server        => standalone,
  resource_path => '/vagrant/README.md',
  dependencies  => ['javax.api', 'javax.transaction.api'],
}
