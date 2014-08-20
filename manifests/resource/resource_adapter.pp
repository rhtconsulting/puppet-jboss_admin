# == Defines jboss_admin::resource_adapter
#
# resource-adapter
#
# === Parameters
#
# [*archive*]
#   Specifies the resource adapter archive
#
# [*beanvalidationgroups*]
#   Specifies the bean validation groups that should be used
#
# [*bootstrap_context*]
#   Specifies the unique name of the bootstrap context that should be used
#
# [*transaction_support*]
#   Specifies the transaction support level of the resource adapter
#
#
define jboss_admin::resource::resource_adapter (
  $server,
  $archive                        = undef,
  $beanvalidationgroups           = undef,
  $bootstrap_context              = undef,
  $transaction_support            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $archive == undef { fail('The attribute archive is undefined but required') }
    if $transaction_support == undef { fail('The attribute transaction_support is undefined but required') }
  

    $raw_options = { 
      'archive'                      => $archive,
      'beanvalidationgroups'         => $beanvalidationgroups,
      'bootstrap-context'            => $bootstrap_context,
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
