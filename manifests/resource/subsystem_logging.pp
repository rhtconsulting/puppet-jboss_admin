# == Defines jboss_admin::subsystem_logging
#
# The configuration of the logging subsystem.
#
# === Parameters
#
# [*add_logging_api_dependencies*]
#   Indicates whether or not logging API dependencies should be added to deployments during the deployment process. A value of true will add the dependencies to the deployment. A value of false will skip the deployment from being processed for logging API dependencies.
#
#
define jboss_admin::resource::subsystem_logging (
  $server,
  $add_logging_api_dependencies   = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $add_logging_api_dependencies != undef {
      validate_bool($add_logging_api_dependencies)
    }
  

    $raw_options = {
      'add-logging-api-dependencies' => $add_logging_api_dependencies,
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
