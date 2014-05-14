define jboss_admin::datasource (
  $server,
  $enabled        = false,
  $connection_url = undef,
  $driver_name    = undef,
  $jndi_name      = undef,
  $jta            = undef,
  $user_name      = undef,
  $password       = undef,

  $ensure = present
) {

  if $ensure == present {
    jboss_resource {"/subsystem=datasources/data-source=${name}":
      ensure => present,
      options => {
        'connection-url' => $connection_url,
        'driver-name'    => $driver_name,
        'jndi-name'      => $jndi_name,
        'jta'            => $jta,
        'user-name'      => $user_name,
        'password'       => $password
      },
      server => $server
    }  

    if $enabled {
      jboss_exec {"Enable Data Source ${name}":
        command => "/subsystem=datasources/data-source=${name}:enable",
        unless  => "(result == true) of /subsystem=datasources/data-source=${name}:read-attribute(name=enabled)",
        server  => $server
      }
    }
    else {
      jboss_exec {"Disable Data Source ${name}":
        command => "/subsystem=datasources/data-source=${name}:disable",
        onlyif  => "(result == true) of /subsystem=datasources/data-source=${name}:read-attribute(name=enabled)",
        server  => $server
      }
    }
  }

  if $ensure == absent {
    jboss_resource {"/subsystem=datasources/data-source=${name}":
      ensure => absent,
      server => $server
    }
  }
}
