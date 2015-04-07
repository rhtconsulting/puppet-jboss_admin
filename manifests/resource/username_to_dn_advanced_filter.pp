# == Defines jboss_admin::username_to_dn_advanced_filter
#
# An advanced filter configuration to identify the users distinguished name from the username.
#
# === Parameters
#
# [*base_dn*]
#   The starting point of the search for the user.
#
# [*filter*]
#   The filter to use for the LDAP search.
#
# [*force*]
#   Authentication may have already converted the username to a distingushed name, force this to occur again before loading groups.
#
# [*recursive*]
#   Should levels below the starting point be recursively searched?
#
# [*user_dn_attribute*]
#   The attribute on the user entry that contains their distinguished name.
#
#
define jboss_admin::resource::username_to_dn_advanced_filter (
  $server,
  $base_dn                        = undef,
  $filter                         = undef,
  $force                          = undef,
  $recursive                      = undef,
  $user_dn_attribute              = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $force != undef {
      validate_bool($force)
    }
    if $recursive != undef {
      validate_bool($recursive)
    }
  

    $raw_options = {
      'base-dn'                      => $base_dn,
      'filter'                       => $filter,
      'force'                        => $force,
      'recursive'                    => $recursive,
      'user-dn-attribute'            => $user_dn_attribute,
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
