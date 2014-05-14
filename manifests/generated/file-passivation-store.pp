# == Defines jboss_admin::file-passivation-store
#
# A file system based passivation store
#
# === Parameters
#
# [*relative_to*]
#   
#
# [*idle_timeout_unit*]
#   The unit of idle-timeout
#
# [*idle_timeout*]
#   The timeout in units specified by idle-timeout-unit, after which a bean will passivate
#
# [*groups_path*]
#   
#
# [*sessions_path*]
#   
#
# [*subdirectory_count*]
#   
#
# [*max_size*]
#   The maximum number of beans this cache should store before forcing old beans to passivate
#
#
define jboss_admin::file-passivation-store (
  $server,
  $relative_to                    = undef,
  $idle_timeout_unit              = undef,
  $idle_timeout                   = undef,
  $groups_path                    = undef,
  $sessions_path                  = undef,
  $subdirectory_count             = undef,
  $max_size                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_size != undef && !is_integer($max_size) { 
      fail('The attribute max_size is not an integer') 
    }
  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'idle-timeout-unit'            => $idle_timeout_unit,
      'idle-timeout'                 => $idle_timeout,
      'groups-path'                  => $groups_path,
      'sessions-path'                => $sessions_path,
      'subdirectory-count'           => $subdirectory_count,
      'max-size'                     => $max_size,
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
