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
  $path                           = $name
) {
  if $ensure == present {

    if $code != undef and !is_string($code) { 
      fail('The attribute code is not a string') 
    }
    if $flag != undef and !is_string($flag) { 
      fail('The attribute flag is not a string') 
    }
    if $flag != undef and !($flag in ['required','requisite','sufficient','optional']) {
      fail("The attribute flag is not an allowed value: 'required','requisite','sufficient','optional'")
    }
    if $login_module_stack_ref != undef and !is_string($login_module_stack_ref) { 
      fail('The attribute login_module_stack_ref is not a string') 
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
  

    $raw_options = { 
      'code'                         => $code,
      'flag'                         => $flag,
      'login-module-stack-ref'       => $login_module_stack_ref,
      'module'                       => $module,
      'module-options'               => $module_options,
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
