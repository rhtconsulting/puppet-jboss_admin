# == Defines jboss_admin::root_resource
#
# The root node of the server-level management model.
#
# === Parameters
#
# [*release_version*]
#   The version of the JBoss Application Server release this server is running.
#
# [*profile_name*]
#   The name of the server's configuration profile.
#
# [*release_codename*]
#   The codename of the JBoss Application Server release this server is running.
#
# [*schema_locations*]
#   Map of locations of XML schemas used in the configuration XML document, where keys are schema URIs and values are locations where the schema can be found.
#
# [*server_state*]
#   The current state of the server controller; either STARTING, RUNNING or RESTART_REQUIRED
#
# [*product_name*]
#   The name of the JBoss AS based product that is being run by this server.
#
# [*process_type*]
#   The type of process represented by this root resource. Always has a value of "Server" for a server resource.
#
# [*product_version*]
#   The version of the JBoss AS based product release that is being run by this server.
#
# [*launch_type*]
#   The manner in which the server process was launched. Either "DOMAIN" for a domain mode server launched by a Host Controller, "STANDALONE" for a standalone server launched from the command line, or "EMBEDDED" for a standalone server launched as an embedded part of an application running in the same virtual machine.
#
# [*namespaces*]
#   Map of namespaces used in the configuration XML document, where keys are namespace prefixes and values are schema URIs.
#
# [*name*]
#   The name of this server. If not set, defaults to the runtime value of InetAddress.getLocalHost().getHostName().
#
# [*management_major_version*]
#   The major version of the JBoss AS management interface that is provided by this server.
#
# [*management_minor_version*]
#   The minor version of the JBoss AS management interface that is provided by this server.
#
#
define jboss_admin::resource::root_resource (
  $server,
  $release_version                = undef,
  $profile_name                   = undef,
  $release_codename               = undef,
  $schema_locations               = undef,
  $server_state                   = undef,
  $product_name                   = undef,
  $process_type                   = undef,
  $product_version                = undef,
  $launch_type                    = undef,
  $namespaces                     = undef,
  $name                           = undef,
  $management_major_version       = undef,
  $management_minor_version       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $release_version == undef { fail('The attribute release_version is undefined but required') }
    if $profile_name == undef { fail('The attribute profile_name is undefined but required') }
    if $release_codename == undef { fail('The attribute release_codename is undefined but required') }
    if $server_state == undef { fail('The attribute server_state is undefined but required') }
    if $product_name == undef { fail('The attribute product_name is undefined but required') }
    if $process_type == undef { fail('The attribute process_type is undefined but required') }
    if $product_version == undef { fail('The attribute product_version is undefined but required') }
    if $launch_type == undef { fail('The attribute launch_type is undefined but required') }
    if $management_major_version == undef { fail('The attribute management_major_version is undefined but required') }
    if $management_major_version != undef and !is_integer($management_major_version) { 
      fail('The attribute management_major_version is not an integer') 
    }
    if $management_minor_version == undef { fail('The attribute management_minor_version is undefined but required') }
    if $management_minor_version != undef and !is_integer($management_minor_version) { 
      fail('The attribute management_minor_version is not an integer') 
    }
  

    $raw_options = { 
      'release-version'              => $release_version,
      'profile-name'                 => $profile_name,
      'release-codename'             => $release_codename,
      'schema-locations'             => $schema_locations,
      'server-state'                 => $server_state,
      'product-name'                 => $product_name,
      'process-type'                 => $process_type,
      'product-version'              => $product_version,
      'launch-type'                  => $launch_type,
      'namespaces'                   => $namespaces,
      'name'                         => $name,
      'management-major-version'     => $management_major_version,
      'management-minor-version'     => $management_minor_version,
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
