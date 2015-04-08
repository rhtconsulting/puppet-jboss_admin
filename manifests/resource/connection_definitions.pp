# == Defines jboss_admin::connection_definitions
#
# Specifies a connection definition.
#
# === Parameters
#
# [*allocation_retry*]
#   The allocation retry element indicates the number of times that allocating a connection should be tried before throwing an exception.
#
# [*allocation_retry_wait_millis*]
#   The allocation retry wait millis element specifies the amount of time, in milliseconds, to wait between retrying to allocate a connection.
#
# [*background_validation*]
#   An element to specify that connections should be validated on a background thread versus being validated prior to use. Changing this value requires a server restart.
#
# [*background_validation_millis*]
#   The background-validation-millis element specifies the amount of time, in milliseconds, that background validation will run. Changing this value requires a server restart.
#
# [*blocking_timeout_wait_millis*]
#   The blocking-timeout-millis element specifies the maximum time, in milliseconds, to block while waiting for a connection before throwing an exception. Note that this blocks only while waiting for locking a connection, and will never throw an exception if creating a new connection takes an inordinately long time.
#
# [*class_name*]
#   Specifies the fully qualified class name of a managed connection factory or admin object.
#
# [*enabled*]
#   Specifies if the resource adapter should be enabled.
#
# [*flush_strategy*]
#   Specifies how the pool should be flush in case of an error. Valid values are: FailingConnectionOnly (default), IdleConnections and EntirePool.
#
# [*idle_timeout_minutes*]
#   The idle-timeout-minutes elements specifies the maximum time, in minutes, a connection may be idle before being closed. The actual maximum time depends also on the IdleRemover scan time, which is half of the smallest idle-timeout-minutes value of any pool. Changing this value requires a server restart..
#
# [*interleaving*]
#   An element to enable interleaving for XA connections.
#
# [*jndi_name*]
#   Specifies the JNDI name for the connection factory.
#
# [*max_pool_size*]
#   The max-pool-size element specifies the maximum number of connections for a pool. No more connections will be created in each sub-pool.
#
# [*min_pool_size*]
#   The min-pool-size element specifies the minimum number of connections for a pool.
#
# [*no_recovery*]
#   Specifies if the connection pool should be excluded from recovery.
#
# [*no_tx_separate_pool*]
#   Oracle does not like XA connections getting used both inside and outside a JTA transaction. To workaround the problem you can create separate sub-pools for the different contexts.
#
# [*pad_xid*]
#   Should the Xid be padded.
#
# [*pool_prefill*]
#   Should the pool be prefilled. Changing this value requires a server restart.
#
# [*pool_use_strict_min*]
#   Specifies if the min-pool-size should be considered strictly.
#
# [*recovery_password*]
#   The password used for recovery.
#
# [*recovery_plugin_class_name*]
#   The fully qualified class name of the recovery plugin implementation.
#
# [*recovery_plugin_properties*]
#   The properties for the recovery plugin.
#
# [*recovery_security_domain*]
#   The security domain used for recovery.
#
# [*recovery_username*]
#   The user name used for recovery.
#
# [*same_rm_override*]
#   The is-same-rm-override element allows one to unconditionally set whether the javax.transaction.xa.XAResource.isSameRM(XAResource) returns true or false.
#
# [*security_application*]
#   Indicates that app supplied parameters (such as from getConnection(user, pw)) are used to distinguish connections in the pool.
#
# [*security_domain*]
#   Specifies the security domain which defines the javax.security.auth.Subject that are used to distinguish connections in the pool.
#
# [*security_domain_and_application*]
#   Indicates that either app supplied parameters (such as from getConnection(user, pw)) or Subject (from security domain) are used to distinguish connections in the pool.
#
# [*use_ccm*]
#   Enable the use of a cached connection manager.
#
# [*use_fast_fail*]
#   Whether to fail a connection allocation on the first try if it is invalid (true) or keep trying until the pool is exhausted of all potential connections (false).
#
# [*use_java_context*]
#   Setting this to false will bind the object into global JNDI.
#
# [*use_try_lock*]
#   Any configured timeout for internal locks on the resource adapter objects in seconds.
#
# [*wrap_xa_resource*]
#   Should the XAResource instances be wrapped in a org.jboss.tm.XAResourceWrapper instance.
#
# [*xa_resource_timeout*]
#   The value is passed to XAResource.setTransactionTimeout(), in seconds. Default is zero.
#
#
define jboss_admin::resource::connection_definitions (
  $server,
  $allocation_retry               = undef,
  $allocation_retry_wait_millis   = undef,
  $background_validation          = undef,
  $background_validation_millis   = undef,
  $blocking_timeout_wait_millis   = undef,
  $class_name                     = undef,
  $enabled                        = undef,
  $flush_strategy                 = undef,
  $idle_timeout_minutes           = undef,
  $interleaving                   = undef,
  $jndi_name                      = undef,
  $max_pool_size                  = undef,
  $min_pool_size                  = undef,
  $no_recovery                    = undef,
  $no_tx_separate_pool            = undef,
  $pad_xid                        = undef,
  $pool_prefill                   = undef,
  $pool_use_strict_min            = undef,
  $recovery_password              = undef,
  $recovery_plugin_class_name     = undef,
  $recovery_plugin_properties     = undef,
  $recovery_security_domain       = undef,
  $recovery_username              = undef,
  $same_rm_override               = undef,
  $security_application           = undef,
  $security_domain                = undef,
  $security_domain_and_application = undef,
  $use_ccm                        = undef,
  $use_fast_fail                  = undef,
  $use_java_context               = undef,
  $use_try_lock                   = undef,
  $wrap_xa_resource               = undef,
  $xa_resource_timeout            = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $allocation_retry != undef and $allocation_retry != undefined and !is_integer($allocation_retry) {
      fail('The attribute allocation_retry is not an integer')
    }
    if $allocation_retry_wait_millis != undef and $allocation_retry_wait_millis != undefined and !is_integer($allocation_retry_wait_millis) {
      fail('The attribute allocation_retry_wait_millis is not an integer')
    }
    if $background_validation != undef and $background_validation != undefined {
      validate_bool($background_validation)
    }
    if $background_validation_millis != undef and $background_validation_millis != undefined and !is_integer($background_validation_millis) {
      fail('The attribute background_validation_millis is not an integer')
    }
    if $blocking_timeout_wait_millis != undef and $blocking_timeout_wait_millis != undefined and !is_integer($blocking_timeout_wait_millis) {
      fail('The attribute blocking_timeout_wait_millis is not an integer')
    }
    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }
    if $flush_strategy != undef and $flush_strategy != undefined and !($flush_strategy in ['UNKNOWN','FailingConnectionOnly','IdleConnections','EntirePool']) {
      fail("The attribute flush_strategy is not an allowed value: 'UNKNOWN','FailingConnectionOnly','IdleConnections','EntirePool'")
    }
    if $idle_timeout_minutes != undef and $idle_timeout_minutes != undefined and !is_integer($idle_timeout_minutes) {
      fail('The attribute idle_timeout_minutes is not an integer')
    }
    if $interleaving != undef and $interleaving != undefined {
      validate_bool($interleaving)
    }
    if $max_pool_size != undef and $max_pool_size != undefined and !is_integer($max_pool_size) {
      fail('The attribute max_pool_size is not an integer')
    }
    if $min_pool_size != undef and $min_pool_size != undefined and !is_integer($min_pool_size) {
      fail('The attribute min_pool_size is not an integer')
    }
    if $no_recovery != undef and $no_recovery != undefined {
      validate_bool($no_recovery)
    }
    if $no_tx_separate_pool != undef and $no_tx_separate_pool != undefined {
      validate_bool($no_tx_separate_pool)
    }
    if $pad_xid != undef and $pad_xid != undefined {
      validate_bool($pad_xid)
    }
    if $pool_prefill != undef and $pool_prefill != undefined {
      validate_bool($pool_prefill)
    }
    if $pool_use_strict_min != undef and $pool_use_strict_min != undefined {
      validate_bool($pool_use_strict_min)
    }
    if $same_rm_override != undef and $same_rm_override != undefined {
      validate_bool($same_rm_override)
    }
    if $security_application != undef and $security_application != undefined {
      validate_bool($security_application)
    }
    if $use_ccm != undef and $use_ccm != undefined {
      validate_bool($use_ccm)
    }
    if $use_fast_fail != undef and $use_fast_fail != undefined {
      validate_bool($use_fast_fail)
    }
    if $use_java_context != undef and $use_java_context != undefined {
      validate_bool($use_java_context)
    }
    if $use_try_lock != undef and $use_try_lock != undefined and !is_integer($use_try_lock) {
      fail('The attribute use_try_lock is not an integer')
    }
    if $wrap_xa_resource != undef and $wrap_xa_resource != undefined {
      validate_bool($wrap_xa_resource)
    }
    if $xa_resource_timeout != undef and $xa_resource_timeout != undefined and !is_integer($xa_resource_timeout) {
      fail('The attribute xa_resource_timeout is not an integer')
    }
  

    $raw_options = {
      'allocation-retry'             => $allocation_retry,
      'allocation-retry-wait-millis' => $allocation_retry_wait_millis,
      'background-validation'        => $background_validation,
      'background-validation-millis' => $background_validation_millis,
      'blocking-timeout-wait-millis' => $blocking_timeout_wait_millis,
      'class-name'                   => $class_name,
      'enabled'                      => $enabled,
      'flush-strategy'               => $flush_strategy,
      'idle-timeout-minutes'         => $idle_timeout_minutes,
      'interleaving'                 => $interleaving,
      'jndi-name'                    => $jndi_name,
      'max-pool-size'                => $max_pool_size,
      'min-pool-size'                => $min_pool_size,
      'no-recovery'                  => $no_recovery,
      'no-tx-separate-pool'          => $no_tx_separate_pool,
      'pad-xid'                      => $pad_xid,
      'pool-prefill'                 => $pool_prefill,
      'pool-use-strict-min'          => $pool_use_strict_min,
      'recovery-password'            => $recovery_password,
      'recovery-plugin-class-name'   => $recovery_plugin_class_name,
      'recovery-plugin-properties'   => $recovery_plugin_properties,
      'recovery-security-domain'     => $recovery_security_domain,
      'recovery-username'            => $recovery_username,
      'same-rm-override'             => $same_rm_override,
      'security-application'         => $security_application,
      'security-domain'              => $security_domain,
      'security-domain-and-application' => $security_domain_and_application,
      'use-ccm'                      => $use_ccm,
      'use-fast-fail'                => $use_fast_fail,
      'use-java-context'             => $use_java_context,
      'use-try-lock'                 => $use_try_lock,
      'wrap-xa-resource'             => $wrap_xa_resource,
      'xa-resource-timeout'          => $xa_resource_timeout,
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
