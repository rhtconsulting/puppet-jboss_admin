# Class: profile::database
#
# This module manages a simple MySql database
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class profile::database {
  
  class { '::mysql::server':
    root_password => 'vagrant',
    override_options => {
      mysqld => {
        "default-storage-engine" => "INNODB",
        "bind_address" => "0.0.0.0"
      }
    }
  }

  mysql::db { 'test':
    user => 'vagrant',
    password => 'vagrant',
    host => '%',
    grant => ['ALL']
  }
  -> mysql_user { 'vagrant@localhost':
    password_hash => mysql_password('vagrant'),
    provider      => mysql
  }
  -> mysql_grant { 'vagrant@localhost/*.*':
    privileges => ['ALL'],
    provider   => mysql,
    user       => 'vagrant@localhost',
    table      => '*.*'
  }
}
