# == Defines jboss_admin::authentication_ldap
#
# Configuration to use LDAP as the user repository.
#
# === Parameters
#
# [*base_dn*]
#   The base distinguished name to commence the search for the user.
#
# [*user_dn*]
#   The name of the attribute which is the user's distinguished name.
#
# [*username_attribute*]
#   The name of the attribute to search for the user. This filter will then perform a simple search where the username entered by the user matches the attribute specified here.
#
# [*connection*]
#   The name of the connection to use to connect to LDAP.
#
# [*advanced_filter*]
#   The fully defined filter to be used to search for the user based on their entered user ID. The filter should contain a variable in the form {0} - this will be replaced with the username supplied by the user.
#
# [*recursive*]
#   Whether the search should be recursive.
#
#
define jboss_admin::resource::authentication_ldap (
  $server,
  $base_dn                        = undef,
  $user_dn                        = undef,
  $username_attribute             = undef,
  $connection                     = undef,
  $advanced_filter                = undef,
  $recursive                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'base-dn'                      => $base_dn,
      'user-dn'                      => $user_dn,
      'username-attribute'           => $username_attribute,
      'connection'                   => $connection,
      'advanced-filter'              => $advanced_filter,
      'recursive'                    => $recursive,
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
