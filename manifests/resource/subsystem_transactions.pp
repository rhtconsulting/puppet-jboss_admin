# == Defines jboss_admin::subsystem_transactions
#
# The configuration of the transactions subsystem.
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
# [*jts*]
#   If true this enables the Java Transaction Service
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
#
define jboss_admin::resource::subsystem_transactions (
  $server,
  $default_timeout                = undef,
  $enable_statistics              = undef,
  $enable_tsm_status              = undef,
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
      'default-timeout'              => $default_timeout,
      'enable-statistics'            => $enable_statistics,
      'enable-tsm-status'            => $enable_tsm_status,
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
