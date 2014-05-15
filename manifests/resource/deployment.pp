# == Defines jboss_admin::deployment
#
# A deployment represents anything that can be deployed (e.g. an application such as EJB-JAR, WAR, EAR, any kind of standard archive such as RAR or JBoss-specific deployment) into a server.
#
# === Parameters
#
# [*runtime_name*]
#   Name by which the deployment should be known within a server's runtime. This would be equivalent to the file name of a deployment file, and would form the basis for such things as default Java Enterprise Edition application and module names. This would typically be the same as 'name', but in some cases users may wish to have two deployments with the same 'runtime-name' (e.g. two versions of "foo.war") both available in the deployment content repository, in which case the deployments would need to have distinct 'name' values but would have the same 'runtime-name'.
#
# [*persistent*]
#   Boolean indicating whether the existence of the deployment should be recorded in the persistent server configuration. Only relevant to a standalone mode server. Default is 'true'. A deployment managed by a deployment scanner would have this set to 'false' to ensure the deployment is only deployed at server start if the scanner again detects the deployment.
#
# [*content*]
#   List of pieces of content that comprise the deployment.
#
# [*name*]
#   Unique identifier of the deployment. Must be unique across all deployments.
#
# [*enabled*]
#   Boolean indicating whether the deployment content is currently deployed in the runtime (or should be deployed in the runtime the next time the server starts.)
#
#
define jboss_admin::resource::deployment (
  $server,
  $runtime_name                   = undef,
  $persistent                     = undef,
  $content                        = undef,
  $name                           = undef,
  $enabled                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $runtime_name == undef { fail('The attribute runtime_name is undefined but required') }
    if $persistent == undef { fail('The attribute persistent is undefined but required') }
    if $content == undef { fail('The attribute content is undefined but required') }
    if $name == undef { fail('The attribute name is undefined but required') }
    if $enabled == undef { fail('The attribute enabled is undefined but required') }
  

    $raw_options = { 
      'runtime-name'                 => $runtime_name,
      'persistent'                   => $persistent,
      'content'                      => $content,
      'name'                         => $name,
      'enabled'                      => $enabled,
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
