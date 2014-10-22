jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_admin::resource::stack{ '/subsystem=jgroups/stack=tcpping':
  ensure => present,
  protocols => [{type => TCPPING}, {type => FD_SOCK, 'socket-binding' => 'jgroups-tcp-fd'}],
  transport => {type => tcp, 'socket-binding' => 'jgroups-tcp'}, 
  server => example
}

#jboss_admin::resource::protocol{ '/subsystem=jgroups/stack=tcpping/protocol=TCPPING':
#  ensure => present,
#  type   => TCPPING,
#  server => example
#}

#jboss_admin::resource::protocol{ '/subsystem=jgroups/stack=tcpping/protocol=FD_SOCK':
#  ensure         => present,
#  type           => FD_SOCK,
#  socket_binding => 'jgroups-tcp-fd',
#  server         => example
#}
