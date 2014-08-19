# == Defines jboss_admin::connection_definitions
#
# connection-definitions
#
# === Parameters
#
# [*class_name*]
#   Specifies the fully qualified class name of a managed connection factory or admin object
#
# [*idle_timeout_minutes*]
#   The idle-timeout-minutes elements specifies the maximum time, in minutes, a connection may be idle before being closed. The actual maximum time depends also on the IdleRemover scan time, which is half of the smallest idle-timeout-minutes value of any pool. Changing this value requires a server restart.
#
# [*recovery_plugin_class_name*]
#   The fully qualified class name of the recovery plugin implementation
#
# [*use_java_context*]
#   Setting this to false will bind the object into global JNDI
#
# [*security_domain_and_application*]
#   Indicates that either app supplied parameters (such as from getConnection(user, pw)) or Subject (from security domain) are used to distinguish connections in the pool
#
# [*security_domain*]
#   Specifies the security domain which defines the javax.security.auth.Subject that are used to distinguish connections in the pool
#
# [*background_validation_millis*]
#   The background-validation-millis element specifies the amount of time, in milliseconds, that background validation will run. Changing this value requires a server restart
#
# [*recovery_plugin_properties*]
#   The properties for the recovery plugin
#
# [*jndi_name*]
#   Specifies the JNDI name for the connection factory or admin object
#
# [*use_ccm*]
#   Enable the use of a cached connection manager
#
# [*no_tx_separate_pool*]
#   Oracle does not like XA connections getting used both inside and outside a JTA transaction. To workaround the problem you can create separate sub-pools for the different contexts
#
# [*max_pool_size*]
#   The max-pool-size element specifies the maximum number of connections for a pool. No more connections will be created in each sub-pool
#
# [*security_application*]
#   Indicates that app supplied parameters (such as from getConnection(user, pw)) are used to distinguish connections in the pool
#
# [*use_try_lock*]
#   Any configured timeout for internal locks on the resource adapter objects in seconds
#
# [*background_validation*]
#   An element to specify that connections should be validated on a background thread versus being validated prior to use. Changing this value requires a server restart
#
# [*no_recovery*]
#   Specifies if the connection pool should be excluded from recovery
#
# [*enabled*]
#   Specifies if the resource adapter should be enabled
#
# [*allocation_retry*]
#   The allocation retry element indicates the number of times that allocating a connection should be tried before throwing an exception
#
# [*recovery_username*]
#   The user name used for recovery
#
# [*pad_xid*]
#   Should the Xid be padded
#
# [*interleaving*]
#   An element to enable interleaving for XA connections
#
# [*min_pool_size*]
#   The min-pool-size element specifies the minimum number of connections for a pool
#
# [*use_fast_fail*]
#   Whether to fail a connection allocation on the first try if it is invalid (true) or keep trying until the pool is exhausted of all potential connections (false)
#
# [*allocation_retry_wait_millis*]
#   The allocation retry wait millis element specifies the amount of time, in milliseconds, to wait between retrying to allocate a connection
#
# [*recovery_password*]
#   The password used for recovery
#
# [*same_rm_override*]
#   The is-same-rm-override element allows one to unconditionally set whether the javax.transaction.xa.XAResource.isSameRM(XAResource) returns true or false
#
# [*flush_strategy*]
#   Specifies how the pool should be flush in case of an error. Valid values are: FailingConnectionOnly (default), IdleConnections and EntirePool
#
# [*pool_prefill*]
#   Should the pool be prefilled. Changing this value requires a server restart
#
# [*blocking_timeout_wait_millis*]
#   The blocking-timeout-millis element specifies the maximum time, in milliseconds, to block while waiting for a connection before throwing an exception. Note that this blocks only while waiting for locking a connection, and will never throw an exception if creating a new connection takes an inordinately long time
#
# [*recovery_security_domain*]
#   The security domain used for recovery
#
# [*wrap_xa_resource*]
#   Should the XAResource instances be wrapped in a org.jboss.tm.XAResourceWrapper instance
#
# [*pool_use_strict_min*]
#   Specifies if the min-pool-size should be considered strictly
#
# [*xa_resource_timeout*]
#   The value is passed to XAResource.setTransactionTimeout(), in seconds. Default is zero
#
#
define jboss_admin::resource::connection_definitions (
  $server,
  $class_name                     = undef,
  $idle_timeout_minutes           = undef,
  $recovery_plugin_class_name     = undef,
  $use_java_context               = undef,
  $security_domain_and_application = undef,
  $security_domain                = undef,
  $background_validation_millis   = undef,
  $recovery_plugin_properties     = undef,
  $jndi_name                      = undef,
  $use_ccm                        = undef,
  $no_tx_separate_pool            = undef,
  $max_pool_size                  = undef,
  $security_application           = undef,
  $use_try_lock                   = undef,
  $background_validation          = undef,
  $no_recovery                    = undef,
  $enabled                        = undef,
  $allocation_retry               = undef,
  $recovery_username              = undef,
  $pad_xid                        = undef,
  $interleaving                   = undef,
  $min_pool_size                  = undef,
  $use_fast_fail                  = undef,
  $allocation_retry_wait_millis   = undef,
  $recovery_password              = undef,
  $same_rm_override               = undef,
  $flush_strategy                 = undef,
  $pool_prefill                   = undef,
  $blocking_timeout_wait_millis   = undef,
  $recovery_security_domain       = undef,
  $wrap_xa_resource               = undef,
  $pool_use_strict_min            = undef,
  $xa_resource_timeout            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_pool_size != undef and !is_integer($max_pool_size) { 
      fail('The attribute max_pool_size is not an integer') 
    }
    if $allocation_retry != undef and !is_integer($allocation_retry) { 
      fail('The attribute allocation_retry is not an integer') 
    }
    if $min_pool_size != undef and !is_integer($min_pool_size) { 
      fail('The attribute min_pool_size is not an integer') 
    }
    if $xa_resource_timeout != undef and !is_integer($xa_resource_timeout) { 
      fail('The attribute xa_resource_timeout is not an integer') 
    }
  

    $raw_options = { 
      'class-name'                   => $class_name,
      'idle-timeout-minutes'         => $idle_timeout_minutes,
      'recovery-plugin-class-name'   => $recovery_plugin_class_name,
      'use-java-context'             => $use_java_context,
      'security-domain-and-application' => $security_domain_and_application,
      'security-domain'              => $security_domain,
      'background-validation-millis' => $background_validation_millis,
      'recovery-plugin-properties'   => $recovery_plugin_properties,
      'jndi-name'                    => $jndi_name,
      'use-ccm'                      => $use_ccm,
      'no-tx-separate-pool'          => $no_tx_separate_pool,
      'max-pool-size'                => $max_pool_size,
      'security-application'         => $security_application,
      'use-try-lock'                 => $use_try_lock,
      'background-validation'        => $background_validation,
      'no-recovery'                  => $no_recovery,
      'enabled'                      => $enabled,
      'allocation-retry'             => $allocation_retry,
      'recovery-username'            => $recovery_username,
      'pad-xid'                      => $pad_xid,
      'interleaving'                 => $interleaving,
      'min-pool-size'                => $min_pool_size,
      'use-fast-fail'                => $use_fast_fail,
      'allocation-retry-wait-millis' => $allocation_retry_wait_millis,
      'recovery-password'            => $recovery_password,
      'same-rm-override'             => $same_rm_override,
      'flush-strategy'               => $flush_strategy,
      'pool-prefill'                 => $pool_prefill,
      'blocking-timeout-wait-millis' => $blocking_timeout_wait_millis,
      'recovery-security-domain'     => $recovery_security_domain,
      'wrap-xa-resource'             => $wrap_xa_resource,
      'pool-use-strict-min'          => $pool_use_strict_min,
      'xa-resource-timeout'          => $xa_resource_timeout,
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
