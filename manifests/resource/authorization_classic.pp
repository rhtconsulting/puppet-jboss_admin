# == Defines jboss_admin::authorization_classic
#
# Authorization configuration. Configures a list of authorization policy modules to be used.
#
# === Parameters
#
# [*policy_modules*]
#   List of authorization modules
#
#
define jboss_admin::resource::authorization_classic (
  $server,
  $policy_modules                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $policy_modules != undef and $policy_modules != undefined and !is_array($policy_modules) {
      fail('The attribute policy_modules is not an array')
    }
  

    $raw_options = {
      'policy-modules'               => $policy_modules,
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
