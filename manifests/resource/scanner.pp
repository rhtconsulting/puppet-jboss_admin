# == Defines jboss_admin::scanner
#
# The configuration of the deployment scanner subsystem
#
# === Parameters
#
# [*auto_deploy_exploded*]
#   Allows the automatic deployment of exploded content without requiring a .dodeploy marker file. Recommended for only basic development scenarios to prevent exploded application deployment from occuring during changes by the developer or operating system.
#
# [*auto_deploy_xml*]
#   Allows automatic deployment of XML content without requiring a .dodeploy marker file.
#
# [*auto_deploy_zipped*]
#   Allows automatic deployment of zipped content without requiring a .dodeploy marker file.
#
# [*deployment_timeout*]
#   The time value in seconds for the deployment scanner to allow a deployment attempt before being cancelled.
#
# [*path*]
#   The actual filesystem path to be scanned. Treated as an absolute path, unless the 'relative-to' attribute is specified, in which case the value is treated as relative to that path.
#
# [*relative_to*]
#   Reference to a filesystem path defined in the "paths" section of the server configuration.
#
# [*scan_enabled*]
#   Flag indicating that all scanning (including initial scanning at startup) should be disabled.
#
# [*scan_interval*]
#   Periodic interval, in milliseconds, at which the repository should be scanned for changes. A value of less than 1 indicates the repository should only be scanned at initial startup.
#
#
define jboss_admin::resource::scanner (
  $server,
  $auto_deploy_exploded           = undef,
  $auto_deploy_xml                = undef,
  $auto_deploy_zipped             = undef,
  $deployment_timeout             = undef,
  $path                           = undef,
  $relative_to                    = undef,
  $scan_enabled                   = undef,
  $scan_interval                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $auto_deploy_exploded != undef { 
      validate_bool($auto_deploy_exploded)
    }
    if $auto_deploy_xml != undef { 
      validate_bool($auto_deploy_xml)
    }
    if $auto_deploy_zipped != undef { 
      validate_bool($auto_deploy_zipped)
    }
    if $deployment_timeout != undef and !is_integer($deployment_timeout) { 
      fail('The attribute deployment_timeout is not an integer') 
    }
    if $scan_enabled != undef { 
      validate_bool($scan_enabled)
    }
    if $scan_interval != undef and !is_integer($scan_interval) { 
      fail('The attribute scan_interval is not an integer') 
    }
  

    $raw_options = { 
      'auto-deploy-exploded'         => $auto_deploy_exploded,
      'auto-deploy-xml'              => $auto_deploy_xml,
      'auto-deploy-zipped'           => $auto_deploy_zipped,
      'deployment-timeout'           => $deployment_timeout,
      'path'                         => $path,
      'relative-to'                  => $relative_to,
      'scan-enabled'                 => $scan_enabled,
      'scan-interval'                => $scan_interval,
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
