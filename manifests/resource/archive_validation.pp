# == Defines jboss_admin::archive_validation
#
# Archive validation for resource adapters
#
# === Parameters
#
# [*enabled*]
#   Specify whether archive validation is enabled
#
# [*fail_on_error*]
#   Should an archive validation error report fail the deployment
#
# [*fail_on_warn*]
#   Should an archive validation warning report fail the deployment
#
#
define jboss_admin::resource::archive_validation (
  $server,
  $enabled                        = undef,
  $fail_on_error                  = undef,
  $fail_on_warn                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $enabled != undef and !is_bool($enabled) { 
      fail('The attribute enabled is not a boolean') 
    }
    if $fail_on_error != undef and !is_bool($fail_on_error) { 
      fail('The attribute fail_on_error is not a boolean') 
    }
    if $fail_on_warn != undef and !is_bool($fail_on_warn) { 
      fail('The attribute fail_on_warn is not a boolean') 
    }
  

    $raw_options = { 
      'enabled'                      => $enabled,
      'fail-on-error'                => $fail_on_error,
      'fail-on-warn'                 => $fail_on_warn,
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
