# == Defines jboss_admin::transport_TRANSPORT
#
# The description of the transport used by this cache container
#
# === Parameters
#
# [*executor*]
#   The executor to use for the transport
#
# [*site*]
#   A site identifier for the transport
#
# [*rack*]
#   A rack identifier for the transport
#
# [*stack*]
#   The jgroups stack to use for the transport
#
# [*machine*]
#   A machine identifier for the transport
#
# [*cluster*]
#   The name of the group communication cluster
#
# [*lock_timeout*]
#   The timeout for locks for the transport
#
#
define jboss_admin::transport_TRANSPORT (
  $server,
  $executor                       = undef,
  $site                           = undef,
  $rack                           = undef,
  $stack                          = undef,
  $machine                        = undef,
  $cluster                        = undef,
  $lock_timeout                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'executor'                     => $executor,
      'site'                         => $site,
      'rack'                         => $rack,
      'stack'                        => $stack,
      'machine'                      => $machine,
      'cluster'                      => $cluster,
      'lock-timeout'                 => $lock_timeout,
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
