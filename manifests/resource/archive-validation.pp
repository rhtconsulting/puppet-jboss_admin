# == Defines jboss_admin::archive-validation
#
# jca.archive-validation
#
# === Parameters
#
# [*fail_on_warn*]
#   Should an archive validation warning report fail the deployment
#
# [*enabled*]
#   Specify whether archive validation is enabled
#
# [*fail_on_error*]
#   Should an archive validation error report fail the deployment
#
#
define jboss_admin::resource::archive-validation (
  $server,
  $fail_on_warn                   = undef,
  $enabled                        = undef,
  $fail_on_error                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'fail-on-warn'                 => $fail_on_warn,
      'enabled'                      => $enabled,
      'fail-on-error'                => $fail_on_error,
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
