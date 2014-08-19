file {'/etc/motd':
  content => 'Welcome to the jboss_admin development environment!'
}

package {'bundler':
  provider => gem
}

package {'git':
  ensure => installed
}

package { "java-1.7.0-openjdk-devel" :
  ensure => installed
}
-> file { '/var/tmp/jboss-eap-6.2.0.zip':
  source => 'puppet:///modules/jboss/jboss-eap-6.2.0.zip'
}
-> class { 'jboss':
  install => source,
  version => '7',
  install_source  => '/tmp/jboss-eap-6.2.0.zip',
  created_dirname => 'jboss-eap-6.2',
  bindaddr => '0.0.0.0'
}
