# == Defines jboss_admin::commit_markable_resource
#
# a CMR resource (i.e. a local resource that can reliably participate in an XA transaction)
#
# === Parameters
#
# [*batch_size*]
#   Batch size for this CMR resource
#
# [*immediate_cleanup*]
#   Immediate cleanup associated to this CMR resource
#
# [*jndi_name*]
#   JNDi name of this CMR resource
#
# [*resource_name*]
#   table name for storing XIDs
#
#
define jboss_admin::resource::commit_markable_resource (
  $server,
  $batch_size                     = undef,
  $immediate_cleanup              = undef,
  $jndi_name                      = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $batch_size != undef and $batch_size != undefined and !is_integer($batch_size) {
      fail('The attribute batch_size is not an integer')
    }
    if $immediate_cleanup != undef and $immediate_cleanup != undefined {
      validate_bool($immediate_cleanup)
    }

    $raw_options = {
      'batch-size'                   => $batch_size,
      'immediate-cleanup'            => $immediate_cleanup,
      'jndi-name'                    => $jndi_name,
      'name'                         => $resource_name,
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
