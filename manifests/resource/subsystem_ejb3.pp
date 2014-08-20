# == Defines jboss_admin::subsystem_ejb3
#
# The configuration of the ejb3 subsystem.
#
# === Parameters
#
# [*default_clustered_sfsb_cache*]
#   Name of the default stateful bean cache, which will be applicable to all clustered stateful EJBs, unless overridden at the deployment or bean level
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
# [*default_resource_adapter_name*]
#   Name of the default resource adapter name that will be used by MDBs, unless overridden at the deployment or bean level
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
# [*in_vm_remote_interface_invocation_pass_by_value*]
#   If set to false, the parameters to invocations on remote interface of an EJB, will be passed by reference. Else, the parameters will be passed by value.
#
#
define jboss_admin::resource::subsystem_ejb3 (
  $server,
  $default_clustered_sfsb_cache   = undef,
  $default_entity_bean_instance_pool = undef,
  $default_entity_bean_optimistic_locking = undef,
  $default_mdb_instance_pool      = undef,
  $default_resource_adapter_name  = undef,
  $default_sfsb_cache             = undef,
  $default_singleton_bean_access_timeout = undef,
  $default_slsb_instance_pool     = undef,
  $default_stateful_bean_access_timeout = undef,
  $in_vm_remote_interface_invocation_pass_by_value = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'default-clustered-sfsb-cache' => $default_clustered_sfsb_cache,
      'default-entity-bean-instance-pool' => $default_entity_bean_instance_pool,
      'default-entity-bean-optimistic-locking' => $default_entity_bean_optimistic_locking,
      'default-mdb-instance-pool'    => $default_mdb_instance_pool,
      'default-resource-adapter-name' => $default_resource_adapter_name,
      'default-sfsb-cache'           => $default_sfsb_cache,
      'default-singleton-bean-access-timeout' => $default_singleton_bean_access_timeout,
      'default-slsb-instance-pool'   => $default_slsb_instance_pool,
      'default-stateful-bean-access-timeout' => $default_stateful_bean_access_timeout,
      'in-vm-remote-interface-invocation-pass-by-value' => $in_vm_remote_interface_invocation_pass_by_value,
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
