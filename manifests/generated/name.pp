# == Defines jboss_admin::name
#
# The management interface for a memory pool. A memory pool represents the memory resource managed by the Java virtual machine and is managed by one or more memory managers.
#
# === Parameters
#
# [*usage_threshold*]
#   The usage threshold value of this memory pool in bytes. A memory pool may not support a usage threshold. If "usage-threshold-supported", is "false" trying to read this attribute via the "read-attribute" operation will result in failure, and the value of this attribute in the result of a "read-resource" operation will be "undefined".
#
# [*collection_usage_threshold*]
#   The collection usage threshold value of this memory pool in bytes. A memory pool may not support a collection usage threshold. If "collection-usage-threshold-supported", is "false" trying to read this attribute via the "read-attribute" operation will result in failure, and the value of this attribute in the result of a "read-resource" operation will be "undefined".
#
#
define jboss_admin::name (
  $server,
  $usage_threshold                = undef,
  $collection_usage_threshold     = undef,
  $ensure = present,
  $path   = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'usage-threshold'              => $usage_threshold,
      'collection-usage-threshold'   => $collection_usage_threshold,
    }
    $options = delete_undef_values($raw_options)

    resource { $path:
      ensure  => $ensure,
      server  => $server,
      options => $options
    }

  }

  if $ensure == absent {
    resource { $path:
      ensure => $ensure,
      server => $server
    }
  }


}
