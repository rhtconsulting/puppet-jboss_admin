file {'/etc/motd':
  content => 'Welcome to the jboss_admin development environment using JBoss EAP 6.x!',
}

package {'bundler':
  provider => gem,
}

package {'git':
  ensure => installed,
}

package { 'java-1.7.0-openjdk-devel' :
  ensure => installed,
}
-> class { 'jboss':
  install         => source,
  version         => '7',
  install_source  => '/tmp/jboss-eap.zip',
  created_dirname => 'jboss-eap',
  bindaddr        => '0.0.0.0',
}
