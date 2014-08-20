# == Defines jboss_admin::stack
#
# The configuration of a JGroups protocol stack.
#
# === Parameters
#
# [*protocols*]
#   The list of configured protocols for a protocol stack.
#
#
define jboss_admin::resource::stack (
  $server,
  $protocols                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'protocols'                    => $protocols,
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
