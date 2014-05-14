Jboss Admin Puppet Module
=========================

This module manages the resources within a running Jboss Wildfly (>= 7) or EAP 
(>= 6) container. For now it does not install the container, please refer to 
[example42/puppet-jboss](https://github.com/example42/puppet-jboss) for a
puppet module which handles initial Jboss installation.

This module can be used to configure any resource which can be managed from the
Jboss CLI, including but not limited to:

* subsystems
* data-sources
* security-domains
* system-properties
* thread-pools
* etcetera

Status
------

This module is currently in **pre-alpha**. Significant portions of 
functionality have not yet been tested, and may not work. Backwards 
compatibility will not be maintained between versions, as it becomes necessary
to make larger scale changes.

Please reference the issues for this project to understand the current defects
and functionality under implementation.

Founding Concepts
-----------------

This module is divided into two different sets of types: porcelain and 
plumbing. The intent is that the plumbing types will provide full coverage of
container configuration with a generic interface, while the porcelain types
provide easy to use interfaces for specific container resources. Porcelain
types have enhanced documentation, validation, and error handling that is
specific to a single resource.

Currently there are two plumbing types on which all porcelain types are built:

* jboss_resource
  Ensures that a specific resource path is present or absent, and that all 
  attributes have the specified values. Non-specified attributes are ignored.
* jboss_exec
  Executes the specified command within the Jboss CLI. Executing the command
  can be made conditional based on the result of another command. This support
  is not dependent on a specific version if EAP/Wildfly.

There are currently over 100 porcelain types. For example, here are a few
porcelain types:

* access-log_configuration
* acl_classic
* admin-objects
* archive-validation_archive-validation
* async-handler
* audit_classic
* authentication_classic
* authentication_jaas
* authentication_jaspi
* authentication_ldap
* authentication_properties
* authentication_truststore
* authorization_classic
* authorization_properties 

###Dependency Ordering###

This module attempts to decrease the amount of explicit dependency management
needed by automatically requiring ancestor resources for any type. For example,
`/subsystem=datasources` will always be configured before 
`/subsystem=datasources/data-source=ExampleDS`. 

Similarly, any `jboss_exec` is
only executed after the resource it is being executed against has been 
configured. This can be seen in the plumbing example below, where 
`Jboss_exec[Enable Data Source]` will always run after the data source has been
created.

An explicit dependency must be declared when two resources that are not an
ancestor and child are dependent.

How to User
-----------

Following are some brief examples of using this modules types. Refer to each
types documentation for more details.

The two provided examples both accomplish the same general task of ensuring a
data source exists and is enabled. The main difference is that the porcelain 
type can validate parameter values when the puppet catalogue is compiled 
instead of causing an error while applying to the container. I would suggest 
using the porcelain types when possible.

###Porcelain Types###

~~~
jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_admin::datasource{'/subsystem=datasources/data-source=ExampleDS':
  ensure         => present,
  enabled        => true,
  connection_url => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
  driver_name    => h2,
  jndi_name      => 'java:jboss/datasources/ExampleDS2',
  jta            => true,
  user_name      => sa,
  password       => sa,
  server         => Jboss_admin::Server['main']
}
~~~

###Plumbing Types###

~~~
jboss_admin::server {'main':
  base_path => '/opt/jboss'
}

jboss_resource {'/subsystem=datasources/data-source=ExampleDS':
  ensure => present,
  options => {
    'connection-url' => 'jdbc:h2:mem:test;DB_CLOSE_DELAY=-1',
    'driver-name'    => 'h2',
    'jndi-name'      => 'java:jboss/datasources/ExampleDS2',
    'jta'            => true,
    'user-name'      => 'sa',
    'password'       => 'sa'
  },
  server => Jboss_admin::Server['main']
}

jboss_exec {'Enable Data Source':
  command => '/subsystem=datasources/data-source=ExampleDS:enable',
  unless  => '(result == true) of /subsystem=datasources/data-source=ExampleDS:read-attribute(name=enabled)',
  server  => Jboss_admin::Server['main']
}
~~~


Developer Setup
---------------

This project is provided with a [Vagrant](www.vagrantup.com) setup for 
development of the module. The created VM has a running Jboss AS 7 instance
at `/opt/jboss` for testing purposes.

To execute a test manifest, first execute `bundle` within the vagrant 
directory, then use the following pattern:

    sudo puppet apply tests/enable_ExampleDS2.pp --modulepath=/modules
    
The server is setup for local authentication, and can be accessed with:

    sudo -u jboss /opt/jboss/bin/jboss-cli.sh --connect