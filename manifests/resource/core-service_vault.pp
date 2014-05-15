# == Defines jboss_admin::core-service_vault
#
# Security Vault for attributes.
#
# === Parameters
#
# [*vault_option*]
#   Security Vault option.
#
# [*code*]
#   Fully Qualified Name of the Security Vault Implementation.
#
#
define jboss_admin::resource::core-service_vault (
  $server,
  $vault_option                   = undef,
  $code                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'vault-option'                 => $vault_option,
      'code'                         => $code,
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
