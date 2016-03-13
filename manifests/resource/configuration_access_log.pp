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
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $extended != undef and $extended != undefined {
      validate_bool($extended)
    }
    if $resolve_hosts != undef and $resolve_hosts != undefined {
      validate_bool($resolve_hosts)
    }
    if $rotate != undef and $rotate != undefined {
      validate_bool($rotate)
    }

    $raw_options = {
      'extended'                     => $extended,
      'pattern'                      => $pattern,
      'prefix'                       => $prefix,
      'resolve-hosts'                => $resolve_hosts,
      'rotate'                       => $rotate,
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
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }
}
