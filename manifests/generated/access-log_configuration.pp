# == Defines jboss_admin::access-log_configuration
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
# [*resolve_hosts*]
#   Host resolution.
#
# [*rotate*]
#   Rotate the access log every day.
#
# [*extended*]
#   Enable extended pattern, with more options.
#
#
define jboss_admin::access-log_configuration (
  $server,
  $pattern                        = undef,
  $prefix                         = undef,
  $resolve_hosts                  = undef,
  $rotate                         = undef,
  $extended                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'pattern'                      => $pattern,
      'prefix'                       => $prefix,
      'resolve-hosts'                => $resolve_hosts,
      'rotate'                       => $rotate,
      'extended'                     => $extended,
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
