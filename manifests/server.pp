# = Define: jboss_admin::server
#
# This defines a jboss server to be managed.
# It does not install a jboss server, and the server should already be running
# before this resource is created.
#
# == Parameters
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
  $management_port = 9999,
) {
  anchor{ "Jboss_admin::Server[${name}] End": }
}
