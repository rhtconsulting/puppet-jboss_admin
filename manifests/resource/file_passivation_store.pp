# == Defines jboss_admin::file_passivation_store
#
# A file system based passivation store
#
# === Parameters
#
# [*groups_path*]
#   
#
# [*idle_timeout*]
#   The timeout in units specified by idle-timeout-unit, after which a bean will passivate
#
# [*idle_timeout_unit*]
#   The unit of idle-timeout
#
# [*max_size*]
#   The maximum number of beans this cache should store before forcing old beans to passivate
#
# [*relative_to*]
#   
#
# [*sessions_path*]
#   
#
# [*subdirectory_count*]
#   
#
#
define jboss_admin::resource::file_passivation_store (
  $server,
  $groups_path                    = undef,
  $idle_timeout                   = undef,
  $idle_timeout_unit              = undef,
  $max_size                       = undef,
  $relative_to                    = undef,
  $sessions_path                  = undef,
  $subdirectory_count             = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $groups_path != undef and !is_string($groups_path) { 
      fail('The attribute groups_path is not a string') 
    }
    if $idle_timeout != undef and !is_integer($idle_timeout) { 
      fail('The attribute idle_timeout is not an integer') 
    }
    if $idle_timeout_unit != undef and !is_string($idle_timeout_unit) { 
      fail('The attribute idle_timeout_unit is not a string') 
    }
    if $idle_timeout_unit != undef and !($idle_timeout_unit in ['NANOSECONDS','MICROSECONDS','MILLISECONDS','SECONDS','MINUTES','HOURS','DAYS']) {
      fail("The attribute idle_timeout_unit is not an allowed value: 'NANOSECONDS','MICROSECONDS','MILLISECONDS','SECONDS','MINUTES','HOURS','DAYS'")
    }
    if $max_size != undef and !is_integer($max_size) { 
      fail('The attribute max_size is not an integer') 
    }
    if $relative_to != undef and !is_string($relative_to) { 
      fail('The attribute relative_to is not a string') 
    }
    if $sessions_path != undef and !is_string($sessions_path) { 
      fail('The attribute sessions_path is not a string') 
    }
    if $subdirectory_count != undef and !is_integer($subdirectory_count) { 
      fail('The attribute subdirectory_count is not an integer') 
    }
  

    $raw_options = { 
      'groups-path'                  => $groups_path,
      'idle-timeout'                 => $idle_timeout,
      'idle-timeout-unit'            => $idle_timeout_unit,
      'max-size'                     => $max_size,
      'relative-to'                  => $relative_to,
      'sessions-path'                => $sessions_path,
      'subdirectory-count'           => $subdirectory_count,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }


  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }


}
