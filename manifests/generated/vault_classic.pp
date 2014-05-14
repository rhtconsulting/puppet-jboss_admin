# == Defines jboss_admin::vault_classic
#
# Security Vault for attributes.
#
# === Parameters
#
# [*code*]
#   Fully Qualified Name of the Security Vault Implementation.
#
# [*options*]
#   Security Vault options.
#
#
define jboss_admin::vault_classic (
  $server,
  $code                           = undef,
  $options                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'code'                         => $code,
      'options'                      => $options,
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
