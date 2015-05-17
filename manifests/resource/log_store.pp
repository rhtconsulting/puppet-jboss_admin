# == Defines jboss_admin::log_store
#
# Representation of the transaction logging storage mechanism.
#
# === Parameters
#
# [*type*]
#   Specifies the implementation type of the logging store.
#
#
define jboss_admin::resource::log_store (
  $server,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {


    $raw_options = {
      'type'                         => $type,
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
