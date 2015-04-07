# == Defines jboss_admin::condition
#
# A list of conditions this rule needs to match for rewrite to occur.
#
# === Parameters
#
# [*flags*]
#   Option flags for this condition.
#
# [*pattern*]
#   The pattern to match.
#
# [*test*]
#   Test pattern for the condition.
#
#
define jboss_admin::resource::condition (
  $server,
  $flags                          = undef,
  $pattern                        = undef,
  $test                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

  

    $raw_options = {
      'flags'                        => $flags,
      'pattern'                      => $pattern,
      'test'                         => $test,
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
