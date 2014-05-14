# == Defines jboss_admin::configuration
#
# A Configuration Admin Service entry. The identity of the resource defines the Configuration Admin PID (Persistent Identifier) that entries are associated with.
#
# === Parameters
#
# [*entries*]
#   The list of configuration entries.
#
#
define jboss_admin::configuration (
  $server,
  $entries                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $entries == undef { fail('The attribute entries is undefined but required') }
  

    $raw_options = { 
      'entries'                      => $entries,
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
