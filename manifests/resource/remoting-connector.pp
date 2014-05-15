# == Defines jboss_admin::remoting-connector
#
# A JBoss remoting connector for the JMX subsystem.
#
# === Parameters
#
# [*use_management_endpoint*]
#   If true the connector will use the management endpoint, otherwise it will use the remoting subsystem one
#
#
define jboss_admin::resource::remoting-connector (
  $server,
  $use_management_endpoint        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'use-management-endpoint'      => $use_management_endpoint,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
