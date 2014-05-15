# == Defines jboss_admin::local-cache
#
# A local cache
#
# === Parameters
#
# [*batching*]
#   If enabled, the invocation batching API will be made available for this cache.
#
# [*start*]
#   The cache start mode, which can be EAGER (immediate start) or LAZY (on-demand start).
#
# [*indexing*]
#   If enabled, entries will be indexed when they are added to the cache. Indexes will be updated as entries change or are removed.
#
# [*jndi_name*]
#   The jndi-name to which to bind this cache instance.
#
#
define jboss_admin::resource::local-cache (
  $server,
  $batching                       = undef,
  $start                          = undef,
  $indexing                       = undef,
  $jndi_name                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'batching'                     => $batching,
      'start'                        => $start,
      'indexing'                     => $indexing,
      'jndi-name'                    => $jndi_name,
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
