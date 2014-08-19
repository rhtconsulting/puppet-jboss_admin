# == Defines jboss_admin::core_service_vault
#
# Security Vault for attributes.
#
# === Parameters
#
# [*code*]
#   Fully Qualified Name of the Security Vault Implementation.
#
# [*vault_option*]
#   Security Vault option.
#
#
define jboss_admin::resource::core_service_vault (
  $server,
  $code                           = undef,
  $vault_option                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'code'                         => $code,
      'vault-option'                 => $vault_option,
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
