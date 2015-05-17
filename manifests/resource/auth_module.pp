# == Defines jboss_admin::auth_module
#
# List of modules that map principal, role, and credential information
#
# === Parameters
#
# [*code*]
#   Class name of the module to be instantiated.
#
# [*flag*]
#   The flag controls how the module participates in the overall procedure. Allowed values are requisite, required, sufficient or optional.
#
# [*login_module_stack_ref*]
#   Reference to a login module stack name previously configured in the same security domain.
#
# [*module*]
#   Name of JBoss Module where the mapping module code is located.
#
# [*module_options*]
#   List of module options containing a name/value pair.
#
#
define jboss_admin::resource::auth_module (
  $server,
  $code                           = undef,
  $flag                           = undef,
  $login_module_stack_ref         = undef,
  $module                         = undef,
  $module_options                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $flag != undef and $flag != undefined and !($flag in ['required','requisite','sufficient','optional']) {
      fail('The attribute flag is not an allowed value: "required","requisite","sufficient","optional"')
    }

    $raw_options = {
      'code'                         => $code,
      'flag'                         => $flag,
      'login-module-stack-ref'       => $login_module_stack_ref,
      'module'                       => $module,
      'module-options'               => $module_options,
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
