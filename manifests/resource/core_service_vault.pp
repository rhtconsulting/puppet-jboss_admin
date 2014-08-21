# == Defines jboss_admin::core_service_vault
#
# Security Vault for attributes.
#
# === Parameters
#
# [*code*]
#   Fully Qualified Name of the Security Vault Implementation.
#
# [*module*]
#   The name of the module to load up the vault implementation from.
#
# [*vault_options*]
#   Security Vault options.
#
#
define jboss_admin::resource::core_service_vault (
  $server,
  $code                           = undef,
  $module                         = undef,
  $vault_options                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $code != undef and !is_string($code) { 
      fail('The attribute code is not a string') 
    }
    if $module != undef and !is_string($module) { 
      fail('The attribute module is not a string') 
    }
  

    $raw_options = { 
      'code'                         => $code,
      'module'                       => $module,
      'vault-options'                => $vault_options,
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
