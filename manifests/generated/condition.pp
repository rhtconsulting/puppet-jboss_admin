# == Defines jboss_admin::condition
#
# A list of conditions this rule needs to match for rewrite to occur.
#
# === Parameters
#
# [*pattern*]
#   The pattern to match.
#
# [*flags*]
#   Option flags for this condition.
#
# [*test*]
#   Test pattern for the condition.
#
#
define jboss_admin::condition (
  $server,
  $pattern                        = undef,
  $flags                          = undef,
  $test                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'pattern'                      => $pattern,
      'flags'                        => $flags,
      'test'                         => $test,
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
