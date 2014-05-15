# == Defines jboss_admin::rewrite
#
# A list of rewrite rules that will be processed in order on the URL or vhost specified in the request.
#
# === Parameters
#
# [*pattern*]
#   The pattern that will be matched.
#
# [*substitution*]
#   The string that will replace the original URL or vhost.
#
# [*flags*]
#   Option flags for this rewrite rule.
#
#
define jboss_admin::resource::rewrite (
  $server,
  $pattern                        = undef,
  $substitution                   = undef,
  $flags                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'pattern'                      => $pattern,
      'substitution'                 => $substitution,
      'flags'                        => $flags,
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
