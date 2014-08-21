# == Defines jboss_admin::login_module
#
# List of authentication modules
#
# === Parameters
#
# [*code*]
#   Class name of the module to be instantiated.
#
# [*flag*]
#   The flag controls how the module participates in the overall procedure. Allowed values are requisite, required, sufficient or optional.
#
# [*module*]
#   Name of JBoss Module where the login module is located.
#
# [*module_options*]
#   List of module options containing a name/value pair.
#
#
define jboss_admin::resource::login_module (
  $server,
  $code                           = undef,
  $flag                           = undef,
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
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
  

    $raw_options = { 
      'code'                         => $code,
      'flag'                         => $flag,
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
