# == Defines jboss_admin::identity_trust
#
# Identity trust configuration. Configures a list of trust modules to be used.
#
# === Parameters
#
# [*trust_modules*]
#   List of trust modules
#
#
define jboss_admin::resource::identity_trust (
  $server,
  $trust_modules                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $trust_modules != undef and $trust_modules != undefined and !is_array($trust_modules) {
      fail('The attribute trust_modules is not an array')
    }
  

    $raw_options = {
      'trust-modules'                => $trust_modules,
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
