# == Defines jboss_admin::rewrite
#
# A list of rewrite rules that will be processed in order on the URL or vhost specified in the request.
#
# === Parameters
#
# [*flags*]
#   Option flags for this rewrite rule.
#
# [*pattern*]
#   The pattern that will be matched.
#
# [*substitution*]
#   The string that will replace the original URL or vhost.
#
#
define jboss_admin::resource::rewrite (
  $server,
  $flags                          = undef,
  $pattern                        = undef,
  $substitution                   = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {

    $raw_options = {
      'flags'                        => $flags,
      'pattern'                      => $pattern,
      'substitution'                 => $substitution,
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
