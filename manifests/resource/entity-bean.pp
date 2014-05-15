# == Defines jboss_admin::entity-bean
#
# Entity bean component included in the deployment.
#
# === Parameters
#
# [*pool_max_size*]
#   The maximum size of the pool.
#
# [*pool_create_count*]
#   The number of bean instances that have been created.
#
# [*pool_remove_count*]
#   The number of bean instances that have been removed.
#
# [*declared_roles*]
#   The roles declared (via @DeclareRoles) on this EJB component.
#
# [*pool_current_size*]
#   The current size of the pool.
#
# [*pool_name*]
#   The name of the pool.
#
# [*security_domain*]
#   The security domain for this EJB component.
#
# [*run_as_role*]
#   The run-as role (if any) for this EJB component.
#
# [*component_class_name*]
#   The component's class name.
#
# [*pool_available_count*]
#   The number of available (i.e. not in use) instances in the pool.
#
#
define jboss_admin::resource::entity-bean (
  $server,
  $pool_max_size                  = undef,
  $pool_create_count              = undef,
  $pool_remove_count              = undef,
  $declared_roles                 = undef,
  $pool_current_size              = undef,
  $pool_name                      = undef,
  $security_domain                = undef,
  $run_as_role                    = undef,
  $component_class_name           = undef,
  $pool_available_count           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $pool_max_size != undef and !is_integer($pool_max_size) { 
      fail('The attribute pool_max_size is not an integer') 
    }
    if $pool_create_count != undef and !is_integer($pool_create_count) { 
      fail('The attribute pool_create_count is not an integer') 
    }
    if $pool_remove_count != undef and !is_integer($pool_remove_count) { 
      fail('The attribute pool_remove_count is not an integer') 
    }
    if $pool_current_size != undef and !is_integer($pool_current_size) { 
      fail('The attribute pool_current_size is not an integer') 
    }
    if $pool_available_count != undef and !is_integer($pool_available_count) { 
      fail('The attribute pool_available_count is not an integer') 
    }
  

    $raw_options = { 
      'pool-max-size'                => $pool_max_size,
      'pool-create-count'            => $pool_create_count,
      'pool-remove-count'            => $pool_remove_count,
      'declared-roles'               => $declared_roles,
      'pool-current-size'            => $pool_current_size,
      'pool-name'                    => $pool_name,
      'security-domain'              => $security_domain,
      'run-as-role'                  => $run_as_role,
      'component-class-name'         => $component_class_name,
      'pool-available-count'         => $pool_available_count,
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
