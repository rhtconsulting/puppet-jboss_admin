file {'/etc/motd':
  content => 'Welcome to the jboss_admin development environment Using WildFly 7.x!',
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
  bindaddr        => '0.0.0.0',
}
