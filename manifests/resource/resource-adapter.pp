# == Defines jboss_admin::resource-adapter
#
# resource-adapter
#
# === Parameters
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
# [*transaction_support*]
#   Specifies the transaction support level of the resource adapter
#
#
define jboss_admin::resource::resource-adapter (
  $server,
  $bootstrap_context              = undef,
  $beanvalidationgroups           = undef,
  $archive                        = undef,
  $transaction_support            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $archive == undef { fail('The attribute archive is undefined but required') }
    if $transaction_support == undef { fail('The attribute transaction_support is undefined but required') }
  

    $raw_options = { 
      'bootstrap-context'            => $bootstrap_context,
      'beanvalidationgroups'         => $beanvalidationgroups,
      'archive'                      => $archive,
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
