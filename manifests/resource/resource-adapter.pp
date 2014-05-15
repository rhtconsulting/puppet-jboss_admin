# == Defines jboss_admin::resource-adapter
#
# resource-adapter
#
# === Parameters
#
# [*transaction_support*]
#   Specifies the transaction support level of the resource adapter
#
# [*bootstrap_context*]
#   Specifies the unique name of the bootstrap context that should be used
#
# [*beanvalidationgroups*]
#   Specifies the bean validation groups that should be used
#
# [*archive*]
#   Specifies the resource adapter archive
#
#
define jboss_admin::resource::resource-adapter (
  $server,
  $transaction_support            = undef,
  $bootstrap_context              = undef,
  $beanvalidationgroups           = undef,
  $archive                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $transaction_support == undef { fail('The attribute transaction_support is undefined but required') }
    if $archive == undef { fail('The attribute archive is undefined but required') }
  

    $raw_options = { 
      'transaction-support'          => $transaction_support,
      'bootstrap-context'            => $bootstrap_context,
      'beanvalidationgroups'         => $beanvalidationgroups,
      'archive'                      => $archive,
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
