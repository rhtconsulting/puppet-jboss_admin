# == Defines jboss_admin::transport
#
# The description of the transport used by this cache container
#
# === Parameters
#
# [*rack*]
#   A rack identifier for the transport
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
# [*executor*]
#   The executor to use for the transport
#
# [*stack*]
#   The jgroups stack to use for the transport
#
# [*site*]
#   A site identifier for the transport
#
#
define jboss_admin::resource::transport (
  $server,
  $rack                           = undef,
  $machine                        = undef,
  $cluster                        = undef,
  $lock_timeout                   = undef,
  $executor                       = undef,
  $stack                          = undef,
  $site                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'rack'                         => $rack,
      'machine'                      => $machine,
      'cluster'                      => $cluster,
      'lock-timeout'                 => $lock_timeout,
      'executor'                     => $executor,
      'stack'                        => $stack,
      'site'                         => $site,
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
