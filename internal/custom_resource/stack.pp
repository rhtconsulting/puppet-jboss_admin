# = Defines jboss_admin::stack
#
# The configuration of a JGroups protocol stack.
#
# === Parameters
#
# [*protocols*]
#   The list of configured protocols for a protocol stack.
#
# [*transport*]
#   A JGroups stack transport layer.
#
define jboss_admin::resource::stack (
  $server,
  $protocols                      = undef,
  $transport                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $protocols != undef and !is_array($protocols) {
      fail('The attribute protocols is not an array')
    }
  

    $raw_options = {
      'protocols'                    => $protocols,
      'transport'                    => $transport
    }
    $options = delete_undef_values($raw_options)

    $add_command   = "${path}:add"
    $check_command = "(outcome == success) of ${path}:read-resource()"

    jboss_exec { $add_command:
      unless    => $check_command,
      arguments => $raw_options,
      server    => $server
    }

  }

  if $ensure == absent {
    jboss_resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
