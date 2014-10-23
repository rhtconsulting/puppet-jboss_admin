# == Defines jboss_admin::subsystem_ejb3
#
# The configuration of the ejb3 subsystem.
#
# === Parameters
#
# [*default_clustered_sfsb_cache*]
#   Name of the default stateful bean cache, which will be applicable to all clustered stateful EJBs, unless overridden at the deployment or bean level
#
# [*default_distinct_name*]
#   The default distinct name that is applied to every EJB deployed on this server
#
# [*default_entity_bean_instance_pool*]
#   Name of the default entity bean instance pool, which will be applicable to all entity beans, unless overridden at the deployment or bean level
#
# [*default_entity_bean_optimistic_locking*]
#   If set to true entity beans will use optimistic locking by default
#
# [*default_mdb_instance_pool*]
#   Name of the default MDB instance pool, which will be applicable to all MDBs, unless overridden at the deployment or bean level
#
# [*default_missing_method_permissions_deny_access*]
#   If this is set to true then methods on an EJB with a security domain specified or with other methods with security metadata will have an implicit @DenyAll unless other security metadata is present
#
# [*default_resource_adapter_name*]
#   Name of the default resource adapter name that will be used by MDBs, unless overridden at the deployment or bean level
#
# [*default_security_domain*]
#   The default security domain that will be used for EJBs if the bean doesn't explicitly specify one
#
# [*default_sfsb_cache*]
#   Name of the default stateful bean cache, which will be applicable to all stateful EJBs, unless overridden at the deployment or bean level
#
# [*default_singleton_bean_access_timeout*]
#   The default access timeout for singleton beans
#
# [*default_slsb_instance_pool*]
#   Name of the default stateless bean instance pool, which will be applicable to all stateless EJBs, unless overridden at the deployment or bean level
#
# [*default_stateful_bean_access_timeout*]
#   The default access timeout for stateful beans
#
# [*enable_statistics*]
#   If set to true, enable the collection of invocation statistics.
#
# [*in_vm_remote_interface_invocation_pass_by_value*]
#   If set to false, the parameters to invocations on remote interface of an EJB, will be passed by reference. Else, the parameters will be passed by value.
#
#
define jboss_admin::resource::subsystem_ejb3 (
  $server,
  $default_clustered_sfsb_cache   = undef,
  $default_distinct_name          = undef,
  $default_entity_bean_instance_pool = undef,
  $default_entity_bean_optimistic_locking = undef,
  $default_mdb_instance_pool      = undef,
  $default_missing_method_permissions_deny_access = undef,
  $default_resource_adapter_name  = undef,
  $default_security_domain        = undef,
  $default_sfsb_cache             = undef,
  $default_singleton_bean_access_timeout = undef,
  $default_slsb_instance_pool     = undef,
  $default_stateful_bean_access_timeout = undef,
  $enable_statistics              = undef,
  $in_vm_remote_interface_invocation_pass_by_value = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $default_clustered_sfsb_cache != undef and !is_string($default_clustered_sfsb_cache) { 
      fail('The attribute default_clustered_sfsb_cache is not a string') 
    }
    if $default_distinct_name != undef and !is_string($default_distinct_name) { 
      fail('The attribute default_distinct_name is not a string') 
    }
    if $default_entity_bean_instance_pool != undef and !is_string($default_entity_bean_instance_pool) { 
      fail('The attribute default_entity_bean_instance_pool is not a string') 
    }
    if $default_entity_bean_optimistic_locking != undef { 
      validate_bool($default_entity_bean_optimistic_locking)
    }
    if $default_mdb_instance_pool != undef and !is_string($default_mdb_instance_pool) { 
      fail('The attribute default_mdb_instance_pool is not a string') 
    }
    if $default_missing_method_permissions_deny_access != undef { 
      validate_bool($default_missing_method_permissions_deny_access)
    }
    if $default_resource_adapter_name != undef and !is_string($default_resource_adapter_name) { 
      fail('The attribute default_resource_adapter_name is not a string') 
    }
    if $default_security_domain != undef and !is_string($default_security_domain) { 
      fail('The attribute default_security_domain is not a string') 
    }
    if $default_sfsb_cache != undef and !is_string($default_sfsb_cache) { 
      fail('The attribute default_sfsb_cache is not a string') 
    }
    if $default_singleton_bean_access_timeout != undef and !is_integer($default_singleton_bean_access_timeout) { 
      fail('The attribute default_singleton_bean_access_timeout is not an integer') 
    }
    if $default_slsb_instance_pool != undef and !is_string($default_slsb_instance_pool) { 
      fail('The attribute default_slsb_instance_pool is not a string') 
    }
    if $default_stateful_bean_access_timeout != undef and !is_integer($default_stateful_bean_access_timeout) { 
      fail('The attribute default_stateful_bean_access_timeout is not an integer') 
    }
    if $enable_statistics != undef { 
      validate_bool($enable_statistics)
    }
    if $in_vm_remote_interface_invocation_pass_by_value != undef { 
      validate_bool($in_vm_remote_interface_invocation_pass_by_value)
    }
  

    $raw_options = { 
      'default-clustered-sfsb-cache' => $default_clustered_sfsb_cache,
      'default-distinct-name'        => $default_distinct_name,
      'default-entity-bean-instance-pool' => $default_entity_bean_instance_pool,
      'default-entity-bean-optimistic-locking' => $default_entity_bean_optimistic_locking,
      'default-mdb-instance-pool'    => $default_mdb_instance_pool,
      'default-missing-method-permissions-deny-access' => $default_missing_method_permissions_deny_access,
      'default-resource-adapter-name' => $default_resource_adapter_name,
      'default-security-domain'      => $default_security_domain,
      'default-sfsb-cache'           => $default_sfsb_cache,
      'default-singleton-bean-access-timeout' => $default_singleton_bean_access_timeout,
      'default-slsb-instance-pool'   => $default_slsb_instance_pool,
      'default-stateful-bean-access-timeout' => $default_stateful_bean_access_timeout,
      'enable-statistics'            => $enable_statistics,
      'in-vm-remote-interface-invocation-pass-by-value' => $in_vm_remote_interface_invocation_pass_by_value,
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
