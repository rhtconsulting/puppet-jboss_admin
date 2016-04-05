# == Defines jboss_admin::transport
#
# The description of the transport used by this cache container
#
# === Parameters
#
# [*cluster*]
#   The name of the group communication cluster
#
# [*executor*]
#   The executor to use for the transport
#
# [*lock_timeout*]
#   The timeout for locks for the transport
#
# [*machine*]
#   A machine identifier for the transport
#
# [*rack*]
#   A rack identifier for the transport
#
# [*site*]
#   A site identifier for the transport
#
# [*stack*]
#   The jgroups stack to use for the transport
#
#
define jboss_admin::resource::transport (
  $server,
  $cluster                        = undef,
  $executor                       = undef,
  $lock_timeout                   = undef,
  $machine                        = undef,
  $rack                           = undef,
  $site                           = undef,
  $stack                          = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {
    $raw_options = {
      'cluster'                      => $cluster,
      'executor'                     => $executor,
      'lock-timeout'                 => $lock_timeout,
      'machine'                      => $machine,
      'rack'                         => $rack,
      'site'                         => $site,
      'stack'                        => $stack,
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
    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server
    }
  }
}
