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
  $path                           = $name
) {
  if $ensure == present {

    if $base_dn != undef and !is_string($base_dn) { 
      fail('The attribute base_dn is not a string') 
    }
    if $filter != undef and !is_string($filter) { 
      fail('The attribute filter is not a string') 
    }
    if $force != undef and !is_bool($force) { 
      fail('The attribute force is not a boolean') 
    }
    if $recursive != undef and !is_bool($recursive) { 
      fail('The attribute recursive is not a boolean') 
    }
    if $user_dn_attribute != undef and !is_string($user_dn_attribute) { 
      fail('The attribute user_dn_attribute is not a string') 
    }
  

    $raw_options = { 
      'base-dn'                      => $base_dn,
      'filter'                       => $filter,
      'force'                        => $force,
      'recursive'                    => $recursive,
      'user-dn-attribute'            => $user_dn_attribute,
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
