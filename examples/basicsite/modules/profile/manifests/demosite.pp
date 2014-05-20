# Class: profile::demosite
#
# This module manages a basic EAP server with a deployed application
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class profile::demosite (
  $mysql_uri = 'localhost:3306'
){
  service { "iptables":
    ensure => stopped
  }
  
  class { "maven::maven": }
  
  maven { 'mysql-connector':
    path        => '/tmp/mysql-connector-java-5.1.29.jar',
    groupid     => mysql,
    artifactid  => mysql-connector-java,
    version     => '5.1.29',
    packaging   => jar,
    require     => Class['maven::maven']
  }
  
  package { "java-1.7.0-openjdk-devel" :
    ensure => installed
  }
  -> class { 'jboss':
    install => 'source',
    version => '7'
  }
  -> jboss_admin::server{ 'standalone':
    base_path => '/opt/jboss'
  }
  
  jboss_admin::resource::interface{ ['/interface=management', '/interface=public']:
    ensure        => present,
    server        => standalone,
    any_address   => true,
    inet_address  => undefined
  }
  
  jboss_admin::module{ 'com.mysql':
    ensure        => present,
    server        => standalone,
    resource_path => '/tmp/mysql-connector-java-5.1.29.jar',
    dependencies  => ['javax.api', 'javax.transaction.api'],
    require       => Maven['mysql-connector']
  }
  -> jboss_admin::resource::jdbc-driver{ '/subsystem=datasources/jdbc-driver=mysql':
    ensure                          => present,
    server                          => standalone,
    driver_name                     => mysql,
    driver_module_name              => 'com.mysql',
    driver_xa_datasource_class_name => 'com.mysql.jdbc.jdbc2.optional.MysqlXADataSource',
  }
  -> jboss_admin::resource::data-source { '/subsystem=datasources/data-source=MySqlDS':
    ensure         => present,
    server         => standalone,
    jndi_name      => 'java:jboss/datasources/MySqlDS',
    driver_name    => mysql,
    connection_url => "jdbc:mysql://${mysql_uri}/test",
    user_name      => vagrant,
    password       => vagrant,
    enabled        => true
  }
  
}
