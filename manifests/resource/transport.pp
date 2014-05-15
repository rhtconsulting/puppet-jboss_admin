# == Defines jboss_admin::transport
#
# The description of the transport used by this cache container
#
# === Parameters
#
# [*cluster*]
#   The name of the group communication cluster
#
# [*lock_timeout*]
#   The timeout for locks for the transport
#
# [*executor*]
#   The executor to use for the transport
#
# [*site*]
#   A site identifier for the transport
#
# [*stack*]
#   The jgroups stack to use for the transport
#
# [*rack*]
#   A rack identifier for the transport
#
# [*machine*]
#   A machine identifier for the transport
#
#
define jboss_admin::resource::transport (
  $server,
  $cluster                        = undef,
  $lock_timeout                   = undef,
  $executor                       = undef,
  $site                           = undef,
  $stack                          = undef,
  $rack                           = undef,
  $machine                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'cluster'                      => $cluster,
      'lock-timeout'                 => $lock_timeout,
      'executor'                     => $executor,
      'site'                         => $site,
      'stack'                        => $stack,
      'rack'                         => $rack,
      'machine'                      => $machine,
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
