# Class: role::demoserver
#
# This module manages a host with a full demo deployment of the website and database
#
class role::demoserver {
  file { '/etc/motd':
    content => 'Welcome to the jboss_admin demo environment. Do not make changes locally.'
  }

  class { 'profile::database': }
  class { 'profile::demosite': }

}
