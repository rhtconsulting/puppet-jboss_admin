# == Defines jboss_admin::dynamic_load_provider
#
# Dynamic load provider
#
# === Parameters
#
# [*decay*]
#   Decay
#
# [*history*]
#   History
#
#
define jboss_admin::resource::dynamic_load_provider (
  $server,
  $decay                          = undef,
  $history                        = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $decay != undef and !is_integer($decay) { 
      fail('The attribute decay is not an integer') 
    }
    if $history != undef and !is_integer($history) { 
      fail('The attribute history is not an integer') 
    }
  

    $raw_options = { 
      'decay'                        => $decay,
      'history'                      => $history,
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
