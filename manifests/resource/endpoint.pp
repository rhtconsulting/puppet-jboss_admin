# == Defines jboss_admin::endpoint
#
# WS endpoint
#
# === Parameters
#
# [*class*]
#   Webservice endpoint class.
#
# [*context*]
#   Webservice endpoint context.
#
# [*resource_name*]
#   Webservice endpoint name.
#
# [*type*]
#   Webservice endpoint type.
#
# [*wsdl_url*]
#   Webservice endpoint WSDL URL.
#
#
define jboss_admin::resource::endpoint (
  $server,
  $class                          = undef,
  $context                        = undef,
  $resource_name                  = undef,
  $type                           = undef,
  $wsdl_url                       = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {


    $raw_options = {
      'class'                        => $class,
      'context'                      => $context,
      'name'                         => $resource_name,
      'type'                         => $type,
      'wsdl-url'                     => $wsdl_url,
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
