# == Defines jboss_admin::subsystem_transactions
#
# The configuration of the transaction subsystem.
#
# === Parameters
#
# [*default_timeout*]
#   The default timeout.
#
# [*enable_statistics*]
#   Whether statistics should be enabled.
#
# [*enable_tsm_status*]
#   Whether the transaction status manager (TSM) service, needed for out of process recovery, should be provided or not..
#
# [*hornetq_store_enable_async_io*]
#   Whether AsyncIO should be enabled for the HornetQ journal store. Default is false. The server should be restarted for this setting to take effect.
#
# [*jdbc_action_store_drop_table*]
#   Configure if jdbc action store should drop tables. Default is false. The server should be restarted for this setting to take effect.
#
# [*jdbc_action_store_table_prefix*]
#   Optional prefix for table used to write transcation logs in configured jdbc action store. The server should be restarted for this setting to take effect.
#
# [*jdbc_communication_store_drop_table*]
#   Configure if jdbc communication store should drop tables. Default is false. The server should be restarted for this setting to take effect.
#
# [*jdbc_communication_store_table_prefix*]
#   Optional prefix for table used to write transcation logs in configured jdbc communication store. The server should be restarted for this setting to take effect.
#
# [*jdbc_state_store_drop_table*]
#   Configure if jdbc state store should drop tables. Default is false. The server should be restarted for this setting to take effect.
#
# [*jdbc_state_store_table_prefix*]
#   Optional prefix for table used to write transcation logs in configured jdbc state store. The server should be restarted for this setting to take effect.
#
# [*jdbc_store_datasource*]
#   Jndi name of non-XA datasource used. Datasource sghould be define in datasources subsystem. The server should be restarted for this setting to take effect.
#
# [*jts*]
#   If true this enables the Java Transaction Service. NOTE: use of JTS requires configuration of the JacORB subsystem.
#
# [*node_identifier*]
#   Used to set the node identifier on the core environment.
#
# [*object_store_path*]
#   Denotes a relative or absolute filesystem path denoting where the transaction manager object store should store data. By default the value is treated as relative to the path denoted by the "relative-to" attribute.
#
# [*object_store_relative_to*]
#   References a global path configuration in the domain model, defaulting to the JBoss Application Server data directory (jboss.server.data.dir). The value of the "path" attribute will treated as relative to this path. Use an empty string to disable the default behavior and force the value of the "path" attribute to be treated as an absolute path.
#
# [*path*]
#   Denotes a relative or absolute filesystem path denoting where the transaction manager core should store data. By default the value is treated as relative to the path denoted by the "relative-to" attribute.
#
# [*process_id_socket_binding*]
#   The name of the socket binding configuration to use if the transaction manager should use a socket-based process id. Will be 'undefined' if 'process-id-uuid' is 'true'; otherwise must be set.
#
# [*process_id_socket_max_ports*]
#   The maximum number of ports to search for an open port if the transaction manager should use a socket-based process id. If the port specified by the socket binding referenced in 'process-id-socket-binding' is occupied, the next higher port will be tried until an open port is found or the number of ports specified by this attribute have been tried. Will be 'undefined' if 'process-id-uuid' is 'true'.
#
# [*process_id_uuid*]
#   Indicates whether the transaction manager should use a UUID based process id.
#
# [*recovery_listener*]
#   Used to specify if the recovery system should listen on a network socket or not.
#
# [*relative_to*]
#   References a global path configuration in the domain model, defaulting to the JBoss Application Server data directory (jboss.server.data.dir). The value of the "path" attribute will treated as relative to this path. Use an empty string to disable the default behavior and force the value of the "path" attribute to be treated as an absolute path.
#
# [*socket_binding*]
#   Used to reference the correct socket binding to use for the recovery environment.
#
# [*status_socket_binding*]
#   Used to reference the correct socket binding to use for the transaction status manager.
#
# [*use_hornetq_store*]
#   Use the HornetQ journal store for writing transaction logs. Set to true to enable and to false to use the default log store type. The default log store is normally one file system file per transaction log. The server should be restarted for this setting to take effect. It's alternative to jdbc based store.
#
# [*use_jdbc_store*]
#   Use the jdbc store for writing transaction logs. Set to true to enable and to false to use the default log store type. The default log store is normally one file system file per transaction log. The server should be restarted for this setting to take effect. It's alternative to Horneq based store
#
#
define jboss_admin::resource::subsystem_transactions (
  $server,
  $default_timeout                = undef,
  $enable_statistics              = undef,
  $enable_tsm_status              = undef,
  $hornetq_store_enable_async_io  = undef,
  $jdbc_action_store_drop_table   = undef,
  $jdbc_action_store_table_prefix = undef,
  $jdbc_communication_store_drop_table = undef,
  $jdbc_communication_store_table_prefix = undef,
  $jdbc_state_store_drop_table    = undef,
  $jdbc_state_store_table_prefix  = undef,
  $jdbc_store_datasource          = undef,
  $jts                            = undef,
  $node_identifier                = undef,
  $object_store_path              = undef,
  $object_store_relative_to       = undef,
  $path                           = undef,
  $process_id_socket_binding      = undef,
  $process_id_socket_max_ports    = undef,
  $process_id_uuid                = undef,
  $recovery_listener              = undef,
  $relative_to                    = undef,
  $socket_binding                 = undef,
  $status_socket_binding          = undef,
  $use_hornetq_store              = undef,
  $use_jdbc_store                 = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $default_timeout != undef and $default_timeout != undefined and !is_integer($default_timeout) {
      fail('The attribute default_timeout is not an integer')
    }
    if $enable_statistics != undef and $enable_statistics != undefined {
      validate_bool($enable_statistics)
    }
    if $enable_tsm_status != undef and $enable_tsm_status != undefined {
      validate_bool($enable_tsm_status)
    }
    if $hornetq_store_enable_async_io != undef and $hornetq_store_enable_async_io != undefined {
      validate_bool($hornetq_store_enable_async_io)
    }
    if $jdbc_action_store_drop_table != undef and $jdbc_action_store_drop_table != undefined {
      validate_bool($jdbc_action_store_drop_table)
    }
    if $jdbc_communication_store_drop_table != undef and $jdbc_communication_store_drop_table != undefined {
      validate_bool($jdbc_communication_store_drop_table)
    }
    if $jdbc_state_store_drop_table != undef and $jdbc_state_store_drop_table != undefined {
      validate_bool($jdbc_state_store_drop_table)
    }
    if $jts != undef and $jts != undefined {
      validate_bool($jts)
    }
    if $process_id_socket_max_ports != undef and $process_id_socket_max_ports != undefined and !is_integer($process_id_socket_max_ports) {
      fail('The attribute process_id_socket_max_ports is not an integer')
    }
    if $process_id_uuid != undef and $process_id_uuid != undefined {
      validate_bool($process_id_uuid)
    }
    if $recovery_listener != undef and $recovery_listener != undefined {
      validate_bool($recovery_listener)
    }
    if $use_hornetq_store != undef and $use_hornetq_store != undefined {
      validate_bool($use_hornetq_store)
    }
    if $use_jdbc_store != undef and $use_jdbc_store != undefined {
      validate_bool($use_jdbc_store)
    }

    $raw_options = {
      'default-timeout'              => $default_timeout,
      'enable-statistics'            => $enable_statistics,
      'enable-tsm-status'            => $enable_tsm_status,
      'hornetq-store-enable-async-io' => $hornetq_store_enable_async_io,
      'jdbc-action-store-drop-table' => $jdbc_action_store_drop_table,
      'jdbc-action-store-table-prefix' => $jdbc_action_store_table_prefix,
      'jdbc-communication-store-drop-table' => $jdbc_communication_store_drop_table,
      'jdbc-communication-store-table-prefix' => $jdbc_communication_store_table_prefix,
      'jdbc-state-store-drop-table'  => $jdbc_state_store_drop_table,
      'jdbc-state-store-table-prefix' => $jdbc_state_store_table_prefix,
      'jdbc-store-datasource'        => $jdbc_store_datasource,
      'jts'                          => $jts,
      'node-identifier'              => $node_identifier,
      'object-store-path'            => $object_store_path,
      'object-store-relative-to'     => $object_store_relative_to,
      'path'                         => $path,
      'process-id-socket-binding'    => $process_id_socket_binding,
      'process-id-socket-max-ports'  => $process_id_socket_max_ports,
      'process-id-uuid'              => $process_id_uuid,
      'recovery-listener'            => $recovery_listener,
      'relative-to'                  => $relative_to,
      'socket-binding'               => $socket_binding,
      'status-socket-binding'        => $status_socket_binding,
      'use-hornetq-store'            => $use_hornetq_store,
      'use-jdbc-store'               => $use_jdbc_store,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
