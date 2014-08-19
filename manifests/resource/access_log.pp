# == Defines jboss_admin::access_log
#
# The access log configuration for this virtual server.
#
# === Parameters
#
# [*pattern*]
#   The access log pattern.
#
# [*prefix*]
#   Prefix for the log file name.
#
# [*extended*]
#   Enable extended pattern, with more options.
#
# [*resolve_hosts*]
#   Host resolution.
#
# [*rotate*]
#   Rotate the access log every day.
#
#
define jboss_admin::resource::access_log (
  $server,
  $pattern                        = undef,
  $prefix                         = undef,
  $extended                       = undef,
  $resolve_hosts                  = undef,
  $rotate                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'pattern'                      => $pattern,
      'prefix'                       => $prefix,
      'extended'                     => $extended,
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
