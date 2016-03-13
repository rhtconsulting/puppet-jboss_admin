# == Defines jboss_admin::protocol
#
# The configuration of a protocol within a protocol stack.
#
# === Parameters
#
# [*socket_binding*]
#   The socket binding specification for this protocol layer, used to specify IP interfaces and ports for communication.
#
# [*type*]
#   The implementation class for a protocol, which determines protocol functionality.
#
#
define jboss_admin::resource::protocol (
  $server,
  $socket_binding                 = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  $stack = regsubst($cli_path, '/protocol.*$', '')
  $check_command = "(outcome == success) of ${cli_path}:read-resource()"

  if $type == undef or $type == undefined {
    fail('type is required')
  }

  $add_command    = "${stack}:add-protocol(type=${type})"
  $remove_command = "${stack}:remove-protocol(type=${type})"

  if $ensure == present {

    $raw_options = {
      'socket-binding'               => $socket_binding,
      'type'                         => $type,
    }
    $options = delete_undef_values($raw_options)

    jboss_exec { "${name}: add":
      command => $add_command,
      unless  => $check_command,
      server  => $server
    }
    ->
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_exec { "${name}: remove":
      command => $remove_command,
      onlyif  => $check_command,
      server  => $server
    }
  }
}
