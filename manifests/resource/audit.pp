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
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'provider-modules'             => $provider_modules,
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
