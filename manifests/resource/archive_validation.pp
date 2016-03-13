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
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }
    if $fail_on_error != undef and $fail_on_error != undefined {
      validate_bool($fail_on_error)
    }
    if $fail_on_warn != undef and $fail_on_warn != undefined {
      validate_bool($fail_on_warn)
    }

    $raw_options = {
      'enabled'                      => $enabled,
      'fail-on-error'                => $fail_on_error,
      'fail-on-warn'                 => $fail_on_warn,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
