# == Defines jboss_admin::audit
#
# Auditing configuration. Configures a list of provider modules to be used.
#
# === Parameters
#
# [*provider_modules*]
#   List of provider modules
#
#
define jboss_admin::resource::audit (
  $server,
  $provider_modules               = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $provider_modules != undef and !is_array($provider_modules) { 
      fail('The attribute provider_modules is not an array') 
    }
  

    $raw_options = { 
      'provider-modules'             => $provider_modules,
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
