# == Defines jboss_admin::authentication_ldap
#
# Configuration to use LDAP as the user repository.
#
# === Parameters
#
# [*advanced_filter*]
#   The fully defined filter to be used to search for the user based on their entered user ID. The filter should contain a variable in the form {0} - this will be replaced with the username supplied by the user.
#
# [*allow_empty_passwords*]
#   Should empty passwords be accepted from the user being authenticated.
#
# [*base_dn*]
#   The base distinguished name to commence the search for the user.
#
# [*connection*]
#   The name of the connection to use to connect to LDAP.
#
# [*recursive*]
#   Whether the search should be recursive.
#
# [*user_dn*]
#   The name of the attribute which is the user's distinguished name.
#
# [*username_attribute*]
#   The name of the attribute to search for the user. This filter will then perform a simple search where the username entered by the user matches the attribute specified here.
#
#
define jboss_admin::resource::authentication_ldap (
  $server,
  $advanced_filter                = undef,
  $allow_empty_passwords          = undef,
  $base_dn                        = undef,
  $connection                     = undef,
  $recursive                      = undef,
  $user_dn                        = undef,
  $username_attribute             = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $advanced_filter != undef and !is_string($advanced_filter) { 
      fail('The attribute advanced_filter is not a string') 
    }
    if $allow_empty_passwords != undef and !is_bool($allow_empty_passwords) { 
      fail('The attribute allow_empty_passwords is not a boolean') 
    }
    if $base_dn != undef and !is_string($base_dn) { 
      fail('The attribute base_dn is not a string') 
    }
    if $connection != undef and !is_string($connection) { 
      fail('The attribute connection is not a string') 
    }
    if $recursive != undef and !is_bool($recursive) { 
      fail('The attribute recursive is not a boolean') 
    }
    if $user_dn != undef and !is_string($user_dn) { 
      fail('The attribute user_dn is not a string') 
    }
    if $username_attribute != undef and !is_string($username_attribute) { 
      fail('The attribute username_attribute is not a string') 
    }
  

    $raw_options = { 
      'advanced-filter'              => $advanced_filter,
      'allow-empty-passwords'        => $allow_empty_passwords,
      'base-dn'                      => $base_dn,
      'connection'                   => $connection,
      'recursive'                    => $recursive,
      'user-dn'                      => $user_dn,
      'username-attribute'           => $username_attribute,
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
