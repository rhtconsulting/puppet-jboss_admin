# == Defines jboss_admin::virtual-server
#
# A virtual host.
#
# === Parameters
#
# [*enable_welcome_root*]
#   Whether or not the bundled welcome directory is used as the root web context.
#
# [*default_web_module*]
#   The web module deployment name that will be mapped as the root webapp.
#
# [*alias*]
#   The virtual server aliases
#
# [*name*]
#   A unique virtual host name
#
#
define jboss_admin::virtual-server (
  $server,
  $enable_welcome_root            = undef,
  $default_web_module             = undef,
  $alias                          = undef,
  $name                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'enable-welcome-root'          => $enable_welcome_root,
      'default-web-module'           => $default_web_module,
      'alias'                        => $alias,
      'name'                         => $name,
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
