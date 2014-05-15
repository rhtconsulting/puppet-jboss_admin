# == Defines jboss_admin::xa-data-source
#
# A JDBC XA data-source configuration
#
# === Parameters
#
# [*max_pool_size*]
#   The max-pool-size element specifies the maximum number of connections for a pool. No more connections will be created in each sub-pool
#
# [*reauth_plugin_class_name*]
#   The fully qualified class name of the reauthentication plugin implementation
#
# [*use_try_lock*]
#   Any configured timeout for internal locks on the resource adapter objects in seconds
#
# [*background_validation*]
#   An element to specify that connections should be validated on a background thread versus being validated prior to use. Changing this value can be done only on disabled datasource,  requires a server restart otherwise.
#
# [*no_recovery*]
#   Specifies if the connection pool should be excluded from recovery
#
# [*driver_name*]
#   Defines the JDBC driver the datasource should use. It is a symbolic name matching the the name of installed driver. In case the driver is deployed as jar, the name is the name of deployment unit
#
# [*interleaving*]
#   An element to enable interleaving for XA connections
#
# [*pad_xid*]
#   Should the Xid be padded
#
# [*allocation_retry*]
#   The allocation retry element indicates the number of times that allocating a connection should be tried before throwing an exception
#
# [*stale_connection_checker_class_name*]
#   An org.jboss.jca.adapters.jdbc.StaleConnectionChecker that provides an isStaleConnection(SQLException) method which if it returns true will wrap the exception in an org.jboss.jca.adapters.jdbc.StaleConnectionException
#
# [*spy*]
#   Enable spying of SQL statements
#
# [*recovery_username*]
#   The user name used for recovery
#
# [*enabled*]
#   Specifies if the datasource should be enabled
#
# [*min_pool_size*]
#   The min-pool-size element specifies the minimum number of connections for a pool
#
# [*password*]
#   Specifies the password used when creating a new connection
#
# [*reauth_plugin_properties*]
#   The properties for the reauthentication plugin
#
# [*set_tx_query_timeout*]
#   Whether to set the query timeout based on the time remaining until transaction timeout. Any configured query timeout will be used if there is no transaction
#
# [*use_fast_fail*]
#   Whether to fail a connection allocation on the first try if it is invalid (true) or keep trying until the pool is exhausted of all potential connections (false)
#
# [*new_connection_sql*]
#   Specifies an SQL statement to execute whenever a connection is added to the connection pool
#
# [*same_rm_override*]
#   The is-same-rm-override element allows one to unconditionally set whether the javax.transaction.xa.XAResource.isSameRM(XAResource) returns true or false
#
# [*allocation_retry_wait_millis*]
#   The allocation retry wait millis element specifies the amount of time, in milliseconds, to wait between retrying to allocate a connection
#
# [*stale_connection_checker_properties*]
#   The stale connection checker properties
#
# [*recovery_password*]
#   The password used for recovery
#
# [*pool_prefill*]
#   Should the pool be prefilled. Changing this value can be done only on disabled datasource, requires a server restart otherwise.
#
# [*flush_strategy*]
#   Specifies how the pool should be flush in case of an error. Valid values are: FailingConnectionOnly (default), IdleConnections and EntirePool
#
# [*transaction_isolation*]
#   Set the java.sql.Connection transaction isolation level. Valid values are: TRANSACTION_READ_UNCOMMITTED, TRANSACTION_READ_COMMITTED, TRANSACTION_REPEATABLE_READ, TRANSACTION_SERIALIZABLE and TRANSACTION_NONE
#
# [*validate_on_match*]
#   The validate-on-match element specifies if connection validation should be done when a connection factory attempts to match a managed connection. This is typically exclusive to the use of background validation
#
# [*url_delimiter*]
#   Specifies the delimiter for URLs in connection-url for HA datasources
#
# [*wrap_xa_resource*]
#   Should the XAResource instances be wrapped in a org.jboss.tm.XAResourceWrapper instance
#
# [*blocking_timeout_wait_millis*]
#   The blocking-timeout-millis element specifies the maximum time, in milliseconds, to block while waiting for a connection before throwing an exception. Note that this blocks only while waiting for locking a connection, and will never throw an exception if creating a new connection takes an inordinately long time
#
# [*valid_connection_checker_class_name*]
#   An org.jboss.jca.adapters.jdbc.ValidConnectionChecker that provides an isValidConnection(Connection) method to validate a connection. If an exception is returned that means the connection is invalid. This overrides the check-valid-connection-sql element
#
# [*recovery_security_domain*]
#   The security domain used for recovery
#
# [*pool_use_strict_min*]
#   Specifies if the min-pool-size should be considered strictly
#
# [*prepared_statements_cache_size*]
#   The number of prepared statements per connection in an LRU cache
#
# [*check_valid_connection_sql*]
#   Specify an SQL statement to check validity of a pool connection. This may be called when managed connection is obtained from the pool
#
# [*xa_resource_timeout*]
#   The value is passed to XAResource.setTransactionTimeout(), in seconds. Default is zero
#
# [*jta*]
#   Enable JTA integration
#
# [*url_selector_strategy_class_name*]
#   A class that implements org.jboss.jca.adapters.jdbc.URLSelectorStrategy
#
# [*user_name*]
#   Specify the user name used when creating a new connection
#
# [*idle_timeout_minutes*]
#   The idle-timeout-minutes elements specifies the maximum time, in minutes, a connection may be idle before being closed. The actual maximum time depends also on the IdleRemover scan time, which is half of the smallest idle-timeout-minutes value of any pool. Changing this value can be done only on disabled datasource, requires a server restart otherwise.
#
# [*valid_connection_checker_properties*]
#   The valid connection checker properties
#
# [*recovery_plugin_class_name*]
#   The fully qualified class name of the recovery plugin implementation
#
# [*xa_datasource_class*]
#   The fully qualified name of the javax.sql.XADataSource implementation
#
# [*share_prepared_statements*]
#   Whether to share prepared statements, i.e. whether asking for same statement twice without closing uses the same underlying prepared statement
#
# [*exception_sorter_class_name*]
#   An org.jboss.jca.adapters.jdbc.ExceptionSorter that provides an isExceptionFatal(SQLException) method to validate if an exception should broadcast an error
#
# [*use_java_context*]
#   Setting this to false will bind the datasource into global JNDI
#
# [*security_domain*]
#   Specifies the security domain which defines the javax.security.auth.Subject that are used to distinguish connections in the pool
#
# [*query_timeout*]
#   Any configured query timeout in seconds. If not provided no timeout will be set
#
# [*background_validation_millis*]
#   The background-validation-millis element specifies the amount of time, in milliseconds, that background validation will run. Changing this value can be done only on disabled datasource,  requires a server restart otherwise
#
# [*recovery_plugin_properties*]
#   The properties for the recovery plugin
#
# [*jndi_name*]
#   Specifies the JNDI name for the datasource
#
# [*no_tx_separate_pool*]
#   Oracle does not like XA connections getting used both inside and outside a JTA transaction. To workaround the problem you can create separate sub-pools for the different contexts
#
# [*track_statements*]
#   Whether to check for unclosed statements when a connection is returned to the pool, result sets are closed, a statement is closed or return to the prepared statement cache. Valid values are: "false" - do not track statements, "true" - track statements and result sets and warn when they are not closed, "nowarn" - track statements but do not warn about them being unclosed
#
# [*exception_sorter_properties*]
#   The exception sorter properties
#
# [*use_ccm*]
#   Enable the use of a cached connection manager
#
#
define jboss_admin::resource::xa-data-source (
  $server,
  $max_pool_size                  = undef,
  $reauth_plugin_class_name       = undef,
  $use_try_lock                   = undef,
  $background_validation          = undef,
  $no_recovery                    = undef,
  $driver_name                    = undef,
  $interleaving                   = undef,
  $pad_xid                        = undef,
  $allocation_retry               = undef,
  $stale_connection_checker_class_name = undef,
  $spy                            = undef,
  $recovery_username              = undef,
  $enabled                        = undef,
  $min_pool_size                  = undef,
  $password                       = undef,
  $reauth_plugin_properties       = undef,
  $set_tx_query_timeout           = undef,
  $use_fast_fail                  = undef,
  $new_connection_sql             = undef,
  $same_rm_override               = undef,
  $allocation_retry_wait_millis   = undef,
  $stale_connection_checker_properties = undef,
  $recovery_password              = undef,
  $pool_prefill                   = undef,
  $flush_strategy                 = undef,
  $transaction_isolation          = undef,
  $validate_on_match              = undef,
  $url_delimiter                  = undef,
  $wrap_xa_resource               = undef,
  $blocking_timeout_wait_millis   = undef,
  $valid_connection_checker_class_name = undef,
  $recovery_security_domain       = undef,
  $pool_use_strict_min            = undef,
  $prepared_statements_cache_size = undef,
  $check_valid_connection_sql     = undef,
  $xa_resource_timeout            = undef,
  $jta                            = undef,
  $url_selector_strategy_class_name = undef,
  $user_name                      = undef,
  $idle_timeout_minutes           = undef,
  $valid_connection_checker_properties = undef,
  $recovery_plugin_class_name     = undef,
  $xa_datasource_class            = undef,
  $share_prepared_statements      = undef,
  $exception_sorter_class_name    = undef,
  $use_java_context               = undef,
  $security_domain                = undef,
  $query_timeout                  = undef,
  $background_validation_millis   = undef,
  $recovery_plugin_properties     = undef,
  $jndi_name                      = undef,
  $no_tx_separate_pool            = undef,
  $track_statements               = undef,
  $exception_sorter_properties    = undef,
  $use_ccm                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_pool_size != undef and !is_integer($max_pool_size) { 
      fail('The attribute max_pool_size is not an integer') 
    }
    if $driver_name == undef { fail('The attribute driver_name is undefined but required') }
    if $allocation_retry != undef and !is_integer($allocation_retry) { 
      fail('The attribute allocation_retry is not an integer') 
    }
    if $min_pool_size != undef and !is_integer($min_pool_size) { 
      fail('The attribute min_pool_size is not an integer') 
    }
    if $xa_resource_timeout != undef and !is_integer($xa_resource_timeout) { 
      fail('The attribute xa_resource_timeout is not an integer') 
    }
    if $jndi_name == undef { fail('The attribute jndi_name is undefined but required') }
  

    $raw_options = { 
      'max-pool-size'                => $max_pool_size,
      'reauth-plugin-class-name'     => $reauth_plugin_class_name,
      'use-try-lock'                 => $use_try_lock,
      'background-validation'        => $background_validation,
      'no-recovery'                  => $no_recovery,
      'driver-name'                  => $driver_name,
      'interleaving'                 => $interleaving,
      'pad-xid'                      => $pad_xid,
      'allocation-retry'             => $allocation_retry,
      'stale-connection-checker-class-name' => $stale_connection_checker_class_name,
      'spy'                          => $spy,
      'recovery-username'            => $recovery_username,
      'min-pool-size'                => $min_pool_size,
      'password'                     => $password,
      'reauth-plugin-properties'     => $reauth_plugin_properties,
      'set-tx-query-timeout'         => $set_tx_query_timeout,
      'use-fast-fail'                => $use_fast_fail,
      'new-connection-sql'           => $new_connection_sql,
      'same-rm-override'             => $same_rm_override,
      'allocation-retry-wait-millis' => $allocation_retry_wait_millis,
      'stale-connection-checker-properties' => $stale_connection_checker_properties,
      'recovery-password'            => $recovery_password,
      'pool-prefill'                 => $pool_prefill,
      'flush-strategy'               => $flush_strategy,
      'transaction-isolation'        => $transaction_isolation,
      'validate-on-match'            => $validate_on_match,
      'url-delimiter'                => $url_delimiter,
      'wrap-xa-resource'             => $wrap_xa_resource,
      'blocking-timeout-wait-millis' => $blocking_timeout_wait_millis,
      'valid-connection-checker-class-name' => $valid_connection_checker_class_name,
      'recovery-security-domain'     => $recovery_security_domain,
      'pool-use-strict-min'          => $pool_use_strict_min,
      'prepared-statements-cache-size' => $prepared_statements_cache_size,
      'check-valid-connection-sql'   => $check_valid_connection_sql,
      'xa-resource-timeout'          => $xa_resource_timeout,
      'jta'                          => $jta,
      'url-selector-strategy-class-name' => $url_selector_strategy_class_name,
      'user-name'                    => $user_name,
      'idle-timeout-minutes'         => $idle_timeout_minutes,
      'valid-connection-checker-properties' => $valid_connection_checker_properties,
      'recovery-plugin-class-name'   => $recovery_plugin_class_name,
      'xa-datasource-class'          => $xa_datasource_class,
      'share-prepared-statements'    => $share_prepared_statements,
      'exception-sorter-class-name'  => $exception_sorter_class_name,
      'use-java-context'             => $use_java_context,
      'security-domain'              => $security_domain,
      'query-timeout'                => $query_timeout,
      'background-validation-millis' => $background_validation_millis,
      'recovery-plugin-properties'   => $recovery_plugin_properties,
      'jndi-name'                    => $jndi_name,
      'no-tx-separate-pool'          => $no_tx_separate_pool,
      'track-statements'             => $track_statements,
      'exception-sorter-properties'  => $exception_sorter_properties,
      'use-ccm'                      => $use_ccm,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }

    if $enabled {
      jboss_exec {"Enable Data Source ${name}":
        command => "${name}:enable",
        unless  => "(result == true) of ${name}:read-attribute(name=enabled)",
        server  => $server
      }
    }
    else {
      jboss_exec {"Disable Data Source ${name}":
        command => "${name}:disable",
        onlyif  => "(result == true) of ${name}:read-attribute(name=enabled)",
        server  => $server
      }
    }

  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
