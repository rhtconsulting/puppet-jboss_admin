# == Defines jboss_admin::stateful-session-bean
#
# Stateful session bean component included in the deployment.
#
# === Parameters
#
# [*declared_roles*]
#   The roles declared (via @DeclareRoles) on this EJB component.
#
# [*run_as_role*]
#   The run-as role (if any) for this EJB component.
#
# [*security_domain*]
#   The security domain for this EJB component.
#
# [*component_class_name*]
#   The component's class name.
#
#
define jboss_admin::resource::stateful-session-bean (
  $server,
  $declared_roles                 = undef,
  $run_as_role                    = undef,
  $security_domain                = undef,
  $component_class_name           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'declared-roles'               => $declared_roles,
      'run-as-role'                  => $run_as_role,
      'security-domain'              => $security_domain,
      'component-class-name'         => $component_class_name,
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
