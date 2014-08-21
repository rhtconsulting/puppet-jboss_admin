# == Defines jboss_admin::vault
#
# Security Vault for attributes.
#
# === Parameters
#
# [*code*]
#   Fully Qualified Name of the Security Vault Implementation.
#
# [*vault_options*]
#   Security Vault options.
#
#
define jboss_admin::resource::vault (
  $server,
  $code                           = undef,
  $vault_options                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $code != undef and !is_string($code) { 
      fail('The attribute code is not a string') 
    }
  

    $raw_options = { 
      'code'                         => $code,
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
