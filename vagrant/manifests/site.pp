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
-> class { 'jboss':
  version => '7',
  bindaddr => '0.0.0.0'
}
