# == Defines jboss_admin::subsystem_ee
#
# The configuration of the EE subsystem.
#
# === Parameters
#
# [*annotation_property_replacement*]
#   Flag indicating whether EJB annotations will have property replacements applied
#
# [*ear_subdeployments_isolated*]
#   Flag indicating whether each of the subdeployments within a .ear can access classes belonging to another subdeployment within the same .ear. A value of false means the subdeployments can see classes belonging to other subdeployments within the .ear.
#
# [*global_modules*]
#   A list of modules that should be made available to all deployments.
#
# [*jboss_descriptor_property_replacement*]
#   Flag indicating whether JBoss specific deployment descriptors will have property replacements applied
#
# [*spec_descriptor_property_replacement*]
#   Flag indicating whether descriptors defined by the Java EE specification will have property replacements applied
#
#
define jboss_admin::resource::subsystem_ee (
  $server,
  $annotation_property_replacement = undef,
  $ear_subdeployments_isolated    = undef,
  $global_modules                 = undef,
  $jboss_descriptor_property_replacement = undef,
  $spec_descriptor_property_replacement = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'annotation-property-replacement' => $annotation_property_replacement,
      'ear-subdeployments-isolated'  => $ear_subdeployments_isolated,
      'global-modules'               => $global_modules,
      'jboss-descriptor-property-replacement' => $jboss_descriptor_property_replacement,
      'spec-descriptor-property-replacement' => $spec_descriptor_property_replacement,
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
