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
  $path                           = $name
) {
  if $ensure == present {

    if $flags != undef and !is_string($flags) { 
      fail('The attribute flags is not a string') 
    }
    if $pattern != undef and !is_string($pattern) { 
      fail('The attribute pattern is not a string') 
    }
    if $test != undef and !is_string($test) { 
      fail('The attribute test is not a string') 
    }
  

    $raw_options = { 
      'flags'                        => $flags,
      'pattern'                      => $pattern,
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
