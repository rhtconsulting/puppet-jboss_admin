# = Define: jboss_admin::server
#
# This defines a jboss server to be managed.
# It does not install a jboss server, and the server should already be running
# before this resource is created.
#
# == Parameters
#
# [*cli_execute_timeout*]
#  All CLI commands are wrapped in a timeout.
#  This is the length of that timeout in minutes.
#  Default 5 minutes.
#  Required.
#
#
# Examples:
#
# jboss_admin::server { 'My Jboss Server':
#   base_path       => '/opt/jboss',
#   management_port => 9999,
# }
define jboss_admin::server (
  $base_path,
  $user                        = jboss,
  $group                       = jboss,
  $management_ip               = localhost,
  $management_port             = 9999,
  $cli_execute_timeout_minutes = 5,
) {
  anchor{ "Jboss_admin::Server[${name}] End": }

  if !is_integer($cli_execute_timeout_minutes) {
    fail('jboss_admin::server::cli__execute_timeout_minutes must be an integer')
  }

  jboss_admin::cleanup {$name:
    server => $name
  }

  Jboss_resource<| server == $name |> -> Jboss_admin::Cleanup[$name]
  Jboss_exec<| server == $name and title != "Restart Server ${name}" and title != "Reload Server ${name}" and title != "Check Server Up After ${name}" |> -> Jboss_admin::Cleanup[$name]
}
