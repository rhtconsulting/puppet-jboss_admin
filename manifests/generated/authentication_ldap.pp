# == Defines jboss_admin::authentication_ldap
#
# Configuration to use LDAP as the user repository.
#
# === Parameters
#
# [*username_attribute*]
#   The name of the attribute to search for the user. This filter will then perform a simple search where the username entered by the user matches the attribute specified here.
#
# [*advanced_filter*]
#   The fully defined filter to be used to search for the user based on their entered user ID. The filter should contain a variable in the form {0} - this will be replaced with the username supplied by the user.
#
# [*recursive*]
#   Whether the search should be recursive.
#
# [*base_dn*]
#   The base distinguished name to commence the search for the user.
#
# [*connection*]
#   The name of the connection to use to connect to LDAP.
#
# [*user_dn*]
#   The name of the attribute which is the user's distinguished name.
#
#
define jboss_admin::authentication_ldap (
  $server,
  $username_attribute             = undef,
  $advanced_filter                = undef,
  $recursive                      = undef,
  $base_dn                        = undef,
  $connection                     = undef,
  $user_dn                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'username-attribute'           => $username_attribute,
      'advanced-filter'              => $advanced_filter,
      'recursive'                    => $recursive,
      'base-dn'                      => $base_dn,
      'connection'                   => $connection,
      'user-dn'                      => $user_dn,
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
