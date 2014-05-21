jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_admin::resource::interface{ ['/interface=public', '/interface=management']:
  ensure       => present,
  server       => example,
  inet_address => '${jboss.bind.address.management:127.0.0.1}',
  any_address  => undefined
}
