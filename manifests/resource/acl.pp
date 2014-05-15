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
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'acl-modules'                  => $acl_modules,
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
