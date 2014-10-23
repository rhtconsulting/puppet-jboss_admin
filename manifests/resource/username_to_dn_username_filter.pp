# == Defines jboss_admin::username_to_dn_username_filter
#
# A simple filter configuration to identify the users distinguished name from their username.
#
# === Parameters
#
# [*attribute*]
#   The attribute on the user entry that is their username.
#
# [*base_dn*]
#   The starting point of the search for the user.
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
define jboss_admin::resource::username_to_dn_username_filter (
  $server,
  $attribute                      = undef,
  $base_dn                        = undef,
  $force                          = undef,
  $recursive                      = undef,
  $user_dn_attribute              = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $attribute != undef and !is_string($attribute) { 
      fail('The attribute attribute is not a string') 
    }
    if $base_dn != undef and !is_string($base_dn) { 
      fail('The attribute base_dn is not a string') 
    }
    if $force != undef { 
      validate_bool($force)
    }
    if $recursive != undef { 
      validate_bool($recursive)
    }
    if $user_dn_attribute != undef and !is_string($user_dn_attribute) { 
      fail('The attribute user_dn_attribute is not a string') 
    }
  

    $raw_options = { 
      'attribute'                    => $attribute,
      'base-dn'                      => $base_dn,
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
