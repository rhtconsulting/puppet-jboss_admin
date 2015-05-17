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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $beanvalidationgroups != undef and $beanvalidationgroups != undefined and !is_array($beanvalidationgroups) {
      fail('The attribute beanvalidationgroups is not an array')
    }
    if $transaction_support != undef and $transaction_support != undefined and !($transaction_support in ['NoTransaction','LocalTransaction','XATransaction']) {
      fail('The attribute transaction_support is not an allowed value: "NoTransaction","LocalTransaction","XATransaction"')
    }

    $raw_options = {
      'archive'                      => $archive,
      'beanvalidationgroups'         => $beanvalidationgroups,
      'bootstrap-context'            => $bootstrap_context,
      'config-properties'            => $config_properties,
      'module'                       => $module,
      'transaction-support'          => $transaction_support,
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
