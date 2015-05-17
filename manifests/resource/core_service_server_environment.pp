# == Defines jboss_admin::core_service_server_environment
#
# The server environment.
#
# === Parameters
#
# [*base_dir*]
#   The base directory for JBoss Application Server.
#
# [*config_dir*]
#   The directory where the configurations are stored.
#
# [*config_file*]
#   The configuration file used to launch JBoss Application Server.
#
# [*content_dir*]
#   The directory where user content (e.g. deployments) that is managed by the server is stored.
#
# [*data_dir*]
#   The data directory.
#
# [*deploy_dir*]
#   Deprecated variant of 'content-dir'.
#
# [*ext_dirs*]
#   A list of ext directories.
#
# [*home_dir*]
#   The home directory for JBoss Application Server.
#
# [*host_name*]
#   The host name.
#
# [*initial_running_mode*]
#   The current running mode of the server. Either LIVE (normal operations) or ADMIN_ONLY.  An ADMIN_ONLY server will start any configured management interfaces and accept management requests, but will not start services used for handling end user requests.
#
# [*launch_type*]
#   The type of the running server.
#
# [*log_dir*]
#   The directory where log files are sent.
#
# [*modules_dir*]
#   The directory where modules are found.
#
# [*node_name*]
#   The name of the server node.
#
# [*qualified_host_name*]
#   The qualified host name.
#
# [*server_name*]
#   The name of the server.
#
# [*temp_dir*]
#   The temporary directory.
#
#
define jboss_admin::resource::core_service_server_environment (
  $server,
  $base_dir                       = undef,
  $config_dir                     = undef,
  $config_file                    = undef,
  $content_dir                    = undef,
  $data_dir                       = undef,
  $deploy_dir                     = undef,
  $ext_dirs                       = undef,
  $home_dir                       = undef,
  $host_name                      = undef,
  $initial_running_mode           = undef,
  $launch_type                    = undef,
  $log_dir                        = undef,
  $modules_dir                    = undef,
  $node_name                      = undef,
  $qualified_host_name            = undef,
  $server_name                    = undef,
  $temp_dir                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $initial_running_mode != undef and $initial_running_mode != undefined and !($initial_running_mode in ['NORMAL','ADMIN_ONLY']) {
      fail('The attribute initial_running_mode is not an allowed value: "NORMAL","ADMIN_ONLY"')
    }

    $raw_options = {
      'base-dir'                     => $base_dir,
      'config-dir'                   => $config_dir,
      'config-file'                  => $config_file,
      'content-dir'                  => $content_dir,
      'data-dir'                     => $data_dir,
      'deploy-dir'                   => $deploy_dir,
      'ext-dirs'                     => $ext_dirs,
      'home-dir'                     => $home_dir,
      'host-name'                    => $host_name,
      'initial-running-mode'         => $initial_running_mode,
      'launch-type'                  => $launch_type,
      'log-dir'                      => $log_dir,
      'modules-dir'                  => $modules_dir,
      'node-name'                    => $node_name,
      'qualified-host-name'          => $qualified_host_name,
      'server-name'                  => $server_name,
      'temp-dir'                     => $temp_dir,
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
