jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_admin::resource::interface{ ['/interface=public', '/interface=management']:
  ensure       => present,
  server       => example,
  inet_address => undefined,
  any_address  => true
}
