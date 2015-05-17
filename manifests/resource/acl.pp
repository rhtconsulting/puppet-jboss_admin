# == Defines jboss_admin::acl
#
# Access control list configuration. Configures a list of ACL modules to be used.
#
# === Parameters
#
# [*acl_modules*]
#   List of acl modules
#
#
define jboss_admin::resource::acl (
  $server,
  $acl_modules                    = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $acl_modules != undef and $acl_modules != undefined and !is_array($acl_modules) {
      fail('The attribute acl_modules is not an array')
    }

    $raw_options = {
      'acl-modules'                  => $acl_modules,
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
