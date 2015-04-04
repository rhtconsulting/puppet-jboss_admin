# == Defines jboss_admin::remoting_connector
#
# A JBoss remoting connector for the JMX subsystem.
#
# === Parameters
#
# [*use_management_endpoint*]
#   If true the connector will use the management endpoint, otherwise it will use the remoting subsystem one
#
#
define jboss_admin::resource::remoting_connector (
  $server,
  $use_management_endpoint        = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $use_management_endpoint != undef {
      validate_bool($use_management_endpoint)
    }
  

    $raw_options = {
      'use-management-endpoint'      => $use_management_endpoint,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }


}
