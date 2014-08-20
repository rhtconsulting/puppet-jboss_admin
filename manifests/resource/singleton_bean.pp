# == Defines jboss_admin::singleton_bean
#
# Singleton bean component included in the deployment.
#
# === Parameters
#
# [*component_class_name*]
#   The component's class name.
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
# [*timers*]
#   EJB timers associated with the component.
#
#
define jboss_admin::resource::singleton_bean (
  $server,
  $component_class_name           = undef,
  $declared_roles                 = undef,
  $run_as_role                    = undef,
  $security_domain                = undef,
  $timers                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'component-class-name'         => $component_class_name,
      'declared-roles'               => $declared_roles,
      'run-as-role'                  => $run_as_role,
      'security-domain'              => $security_domain,
      'timers'                       => $timers,
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
