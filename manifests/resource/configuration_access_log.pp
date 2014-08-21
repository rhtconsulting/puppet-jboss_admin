# == Defines jboss_admin::configuration_access_log
#
# The access log configuration for this virtual server.
#
# === Parameters
#
# [*extended*]
#   Enable extended pattern, with more options.
#
# [*pattern*]
#   The access log pattern.
#
# [*prefix*]
#   Prefix for the log file name.
#
# [*resolve_hosts*]
#   Host resolution.
#
# [*rotate*]
#   Rotate the access log every day.
#
#
define jboss_admin::resource::configuration_access_log (
  $server,
  $extended                       = undef,
  $pattern                        = undef,
  $prefix                         = undef,
  $resolve_hosts                  = undef,
  $rotate                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $extended != undef and !is_bool($extended) { 
      fail('The attribute extended is not a boolean') 
    }
    if $pattern != undef and !is_string($pattern) { 
      fail('The attribute pattern is not a string') 
    }
    if $prefix != undef and !is_string($prefix) { 
      fail('The attribute prefix is not a string') 
    }
    if $resolve_hosts != undef and !is_bool($resolve_hosts) { 
      fail('The attribute resolve_hosts is not a boolean') 
    }
    if $rotate != undef and !is_bool($rotate) { 
      fail('The attribute rotate is not a boolean') 
    }
  

    $raw_options = { 
      'extended'                     => $extended,
      'pattern'                      => $pattern,
      'prefix'                       => $prefix,
      'resolve-hosts'                => $resolve_hosts,
      'rotate'                       => $rotate,
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
