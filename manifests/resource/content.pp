# == Defines jboss_admin::content
#
# The content of the deployment overlay
#
# === Parameters
#
# [*content*]
#   The deployment overlay content item
#
#
define jboss_admin::resource::content (
  $server,
  $content                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'content'                      => $content,
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
