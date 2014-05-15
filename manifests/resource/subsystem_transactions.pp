# == Defines jboss_admin::subsystem_transactions
#
# The configuration of the transactions subsystem.
#
# === Parameters
#
# [*enable_tsm_status*]
#   Whether the transaction status manager (TSM) service, needed for out of process recovery, should be provided or not..
#
# [*socket_binding*]
#   Used to reference the correct socket binding to use for the recovery environment.
#
# [*object_store_relative_to*]
#   References a global path configuration in the domain model, defaulting to the JBoss Application Server data directory (jboss.server.data.dir). The value of the "path" attribute will treated as relative to this path. Use an empty string to disable the default behavior and force the value of the "path" attribute to be treated as an absolute path.
#
# [*recovery_listener*]
#   Used to specify if the recovery system should listen on a network socket or not.
#
# [*process_id_socket_binding*]
#   The name of the socket binding configuration to use if the transaction manager should use a socket-based process id. Will be 'undefined' if 'process-id-uuid' is 'true'; otherwise must be set.
#
# [*enable_statistics*]
#   Whether statistics should be enabled.
#
# [*default_timeout*]
#   The default timeout.
#
# [*relative_to*]
#   References a global path configuration in the domain model, defaulting to the JBoss Application Server data directory (jboss.server.data.dir). The value of the "path" attribute will treated as relative to this path. Use an empty string to disable the default behavior and force the value of the "path" attribute to be treated as an absolute path.
#
# [*status_socket_binding*]
#   Used to reference the correct socket binding to use for the transaction status manager.
#
# [*jts*]
#   If true this enables the Java Transaction Service
#
# [*object_store_path*]
#   Denotes a relative or absolute filesystem path denoting where the transaction manager object store should store data. By default the value is treated as relative to the path denoted by the "relative-to" attribute.
#
# [*path*]
#   Denotes a relative or absolute filesystem path denoting where the transaction manager core should store data. By default the value is treated as relative to the path denoted by the "relative-to" attribute.
#
# [*node_identifier*]
#   Used to set the node identifier on the core environment.
#
# [*process_id_uuid*]
#   Indicates whether the transaction manager should use a UUID based process id.
#
# [*process_id_socket_max_ports*]
#   The maximum number of ports to search for an open port if the transaction manager should use a socket-based process id. If the port specified by the socket binding referenced in 'process-id-socket-binding' is occupied, the next higher port will be tried until an open port is found or the number of ports specified by this attribute have been tried. Will be 'undefined' if 'process-id-uuid' is 'true'.
#
#
define jboss_admin::resource::subsystem_transactions (
  $server,
  $enable_tsm_status              = undef,
  $socket_binding                 = undef,
  $object_store_relative_to       = undef,
  $recovery_listener              = undef,
  $process_id_socket_binding      = undef,
  $enable_statistics              = undef,
  $default_timeout                = undef,
  $relative_to                    = undef,
  $status_socket_binding          = undef,
  $jts                            = undef,
  $object_store_path              = undef,
  $path                           = undef,
  $node_identifier                = undef,
  $process_id_uuid                = undef,
  $process_id_socket_max_ports    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $default_timeout != undef and !is_integer($default_timeout) { 
      fail('The attribute default_timeout is not an integer') 
    }
    if $process_id_socket_max_ports != undef and !is_integer($process_id_socket_max_ports) { 
      fail('The attribute process_id_socket_max_ports is not an integer') 
    }
  

    $raw_options = { 
      'enable-tsm-status'            => $enable_tsm_status,
      'socket-binding'               => $socket_binding,
      'object-store-relative-to'     => $object_store_relative_to,
      'recovery-listener'            => $recovery_listener,
      'process-id-socket-binding'    => $process_id_socket_binding,
      'enable-statistics'            => $enable_statistics,
      'default-timeout'              => $default_timeout,
      'relative-to'                  => $relative_to,
      'status-socket-binding'        => $status_socket_binding,
      'jts'                          => $jts,
      'object-store-path'            => $object_store_path,
      'path'                         => $path,
      'node-identifier'              => $node_identifier,
      'process-id-uuid'              => $process_id_uuid,
      'process-id-socket-max-ports'  => $process_id_socket_max_ports,
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
