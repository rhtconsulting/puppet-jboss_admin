# == Defines jboss_admin::authentication_local
#
# Configuration of the local authentication mechanism.
#
# === Parameters
#
# [*allowed_users*]
#   The comma separated list of users that will be accepted using the JBOSS-LOCAL-USER mechanism or '*' to accept all. If specified the default-user is always assumed allowed.
#
# [*default_user*]
#   The name of the default user to assume if no user specified by the remote client.
#
# [*skip_group_loading*]
#   Disable the loading of the users group membership information after local authentication has been used.
#
#
define jboss_admin::resource::authentication_local (
  $server,
  $allowed_users                  = undef,
  $default_user                   = undef,
  $skip_group_loading             = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $skip_group_loading != undef {
      validate_bool($skip_group_loading)
    }
  

    $raw_options = {
      'allowed-users'                => $allowed_users,
      'default-user'                 => $default_user,
      'skip-group-loading'           => $skip_group_loading,
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
