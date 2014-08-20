# == Defines jboss_admin::root_resource
#
# The root node of the server-level management model.
#
# === Parameters
#
# [*launch_type*]
#   The manner in which the server process was launched. Either "DOMAIN" for a domain mode server launched by a Host Controller, "STANDALONE" for a standalone server launched from the command line, or "EMBEDDED" for a standalone server launched as an embedded part of an application running in the same virtual machine.
#
# [*management_major_version*]
#   The major version of the JBoss AS management interface that is provided by this server.
#
# [*management_micro_version*]
#   The micro version of the JBoss AS management interface that is provided by this server.
#
# [*management_minor_version*]
#   The minor version of the JBoss AS management interface that is provided by this server.
#
# [*resource_name*]
#   The name of this server. If not set, defaults to the runtime value of InetAddress.getLocalHost().getHostName().
#
# [*namespaces*]
#   Map of namespaces used in the configuration XML document, where keys are namespace prefixes and values are schema URIs.
#
# [*process_type*]
#   The type of process represented by this root resource. Always has a value of "Server" for a server resource.
#
# [*product_name*]
#   The name of the JBoss AS based product that is being run by this server.
#
# [*product_version*]
#   The version of the JBoss AS based product release that is being run by this server.
#
# [*profile_name*]
#   The name of the server's configuration profile.
#
# [*release_codename*]
#   The codename of the JBoss Application Server release this server is running.
#
# [*release_version*]
#   The version of the JBoss Application Server release this server is running.
#
# [*running_mode*]
#   The current running mode of the server. Either NORMAL (normal operations) or ADMIN_ONLY.  An ADMIN_ONLY server will start any configured management interfaces and accept management requests, but will not start services used for handling end user requests.
#
# [*schema_locations*]
#   Map of locations of XML schemas used in the configuration XML document, where keys are schema URIs and values are locations where the schema can be found.
#
# [*server_state*]
#   The current state of the server controller; either STARTING, RUNNING or RESTART_REQUIRED
#
#
define jboss_admin::resource::root_resource (
  $server,
  $launch_type                    = undef,
  $management_major_version       = undef,
  $management_micro_version       = undef,
  $management_minor_version       = undef,
  $resource_name                  = undef,
  $namespaces                     = undef,
  $process_type                   = undef,
  $product_name                   = undef,
  $product_version                = undef,
  $profile_name                   = undef,
  $release_codename               = undef,
  $release_version                = undef,
  $running_mode                   = undef,
  $schema_locations               = undef,
  $server_state                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $management_major_version != undef and !is_integer($management_major_version) { 
      fail('The attribute management_major_version is not an integer') 
    }
    if $management_micro_version != undef and !is_integer($management_micro_version) { 
      fail('The attribute management_micro_version is not an integer') 
    }
    if $management_minor_version != undef and !is_integer($management_minor_version) { 
      fail('The attribute management_minor_version is not an integer') 
    }
  

    $raw_options = { 
      'launch-type'                  => $launch_type,
      'management-major-version'     => $management_major_version,
      'management-micro-version'     => $management_micro_version,
      'management-minor-version'     => $management_minor_version,
      'name'                         => $resource_name,
      'namespaces'                   => $namespaces,
      'process-type'                 => $process_type,
      'product-name'                 => $product_name,
      'product-version'              => $product_version,
      'profile-name'                 => $profile_name,
      'release-codename'             => $release_codename,
      'release-version'              => $release_version,
      'running-mode'                 => $running_mode,
      'schema-locations'             => $schema_locations,
      'server-state'                 => $server_state,
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
