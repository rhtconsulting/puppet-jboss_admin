# == Defines jboss_admin::resource_adapter
#
# The configuration of a resource adapter.
#
# === Parameters
#
# [*archive*]
#   Specifies the resource adapter archive.
#
# [*beanvalidationgroups*]
#   Specifies the bean validation groups that should be used.
#
# [*bootstrap_context*]
#   Specifies the unique name of the bootstrap context that should be used.
#
# [*config_properties*]
#   Custom defined config properties.
#
# [*module*]
#   Specifies the module from which resource adapter will be loaded
#
# [*transaction_support*]
#   Specifies the transaction support level of the resource adapter.
#
#
define jboss_admin::resource::resource_adapter (
  $server,
  $archive                        = undef,
  $beanvalidationgroups           = undef,
  $bootstrap_context              = undef,
  $config_properties              = undef,
  $module                         = undef,
  $transaction_support            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'archive'                      => $archive,
      'beanvalidationgroups'         => $beanvalidationgroups,
      'bootstrap-context'            => $bootstrap_context,
      'config-properties'            => $config_properties,
      'module'                       => $module,
      'transaction-support'          => $transaction_support,
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
