# == Defines jboss_admin::core-service_server-environment
#
# The server environment.
#
# === Parameters
#
# [*data_dir*]
#   The data directory.
#
# [*initial_running_mode*]
#   The current running mode of the server. Either LIVE (normal operations) or ADMIN_ONLY.  An ADMIN_ONLY server will start any configured management interfaces and accept management requests, but will not start services used for handling end user requests.
#
# [*modules_dir*]
#   The directory where modules are found.
#
# [*node_name*]
#   The name of the server node.
#
# [*ext_dirs*]
#   A list of ext directories.
#
# [*qualified_host_name*]
#   The qualified host name.
#
# [*deploy_dir*]
#   Deprecated variant of 'content-dir'.
#
# [*content_dir*]
#   The directory where user content (e.g. deployments) that is managed by the server is stored.
#
# [*config_dir*]
#   The directory where the configurations are stored.
#
# [*base_dir*]
#   The base directory for JBoss Application Server.
#
# [*log_dir*]
#   The directory where log files are sent.
#
# [*server_name*]
#   The name of the server.
#
# [*home_dir*]
#   The home directory for JBoss Application Server.
#
# [*temp_dir*]
#   The temporary directory.
#
# [*launch_type*]
#   The type of the running server.
#
# [*config_file*]
#   The configuration file used to launch JBoss Application Server.
#
# [*host_name*]
#   The host name.
#
#
define jboss_admin::resource::core-service_server-environment (
  $server,
  $data_dir                       = undef,
  $initial_running_mode           = undef,
  $modules_dir                    = undef,
  $node_name                      = undef,
  $ext_dirs                       = undef,
  $qualified_host_name            = undef,
  $deploy_dir                     = undef,
  $content_dir                    = undef,
  $config_dir                     = undef,
  $base_dir                       = undef,
  $log_dir                        = undef,
  $server_name                    = undef,
  $home_dir                       = undef,
  $temp_dir                       = undef,
  $launch_type                    = undef,
  $config_file                    = undef,
  $host_name                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'data-dir'                     => $data_dir,
      'initial-running-mode'         => $initial_running_mode,
      'modules-dir'                  => $modules_dir,
      'node-name'                    => $node_name,
      'ext-dirs'                     => $ext_dirs,
      'qualified-host-name'          => $qualified_host_name,
      'deploy-dir'                   => $deploy_dir,
      'content-dir'                  => $content_dir,
      'config-dir'                   => $config_dir,
      'base-dir'                     => $base_dir,
      'log-dir'                      => $log_dir,
      'server-name'                  => $server_name,
      'home-dir'                     => $home_dir,
      'temp-dir'                     => $temp_dir,
      'launch-type'                  => $launch_type,
      'config-file'                  => $config_file,
      'host-name'                    => $host_name,
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
