# == Defines jboss_admin::participants
#
# The resources that did work in a transaction.
#
# === Parameters
#
# [*eis_product_name*]
#   The JCA enterprise information system's product name.
#
# [*eis_product_version*]
#   The JCA enterprise information system's product version
#
# [*jmx_name*]
#   The JMX name of this participant.
#
# [*jndi_name*]
#   JNDI name of this participant.
#
# [*status*]
#   Reports the commitment status of this participant (can be one of Pending, Prepared, Failed, Heuristic or Readonly).
#
# [*type*]
#   The type name under which this record is stored.
#
#
define jboss_admin::resource::participants (
  $server,
  $eis_product_name               = undef,
  $eis_product_version            = undef,
  $jmx_name                       = undef,
  $jndi_name                      = undef,
  $status                         = undef,
  $type                           = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $status != undef and !($status in ['PENDING','PREPARED','FAILED','HEURISTIC','READONLY']) {
      fail("The attribute status is not an allowed value: 'PENDING','PREPARED','FAILED','HEURISTIC','READONLY'")
    }
  

    $raw_options = { 
      'eis-product-name'             => $eis_product_name,
      'eis-product-version'          => $eis_product_version,
      'jmx-name'                     => $jmx_name,
      'jndi-name'                    => $jndi_name,
      'status'                       => $status,
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
