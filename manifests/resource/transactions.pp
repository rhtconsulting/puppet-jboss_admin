# == Defines jboss_admin::transactions
#
# The persistent information that the transaction manager stores for the purpose of recovering a transaction in the event of failure. The probe operation will add and remove transactions from the model as the corresponding real transactions start and finish the prepare and commit phases. A stuck transaction will remain in the model until either it is completed or explicitly removed by the delete operation.
#
# === Parameters
#
# [*age_in_seconds*]
#   The time since this transaction was prepared or when the recovery system last tried to recover it.
#
# [*id*]
#   The id of this transaction.
#
# [*jmx_name*]
#   The JMX name of this transaction.
#
# [*type*]
#   The type name under which this record is stored.
#
#
define jboss_admin::resource::transactions (
  $server,
  $age_in_seconds                 = undef,
  $id                             = undef,
  $jmx_name                       = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $age_in_seconds != undef and $age_in_seconds != undefined and !is_integer($age_in_seconds) {
      fail('The attribute age_in_seconds is not an integer')
    }

    $raw_options = {
      'age-in-seconds'               => $age_in_seconds,
      'id'                           => $id,
      'jmx-name'                     => $jmx_name,
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
