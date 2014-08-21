# == Defines jboss_admin::role_mapping
#
# A mapping of users and groups to a specific role.
#
# === Parameters
#
# [*include_all*]
#   Configure if all authenticated users should be automatically assigned this role.
#
#
define jboss_admin::resource::role_mapping (
  $server,
  $include_all                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $include_all != undef and !is_bool($include_all) { 
      fail('The attribute include_all is not a boolean') 
    }
  

    $raw_options = { 
      'include-all'                  => $include_all,
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
