# == Defines jboss_admin::endpoint
#
# Webservice endpoint.
#
# === Parameters
#
# [*type*]
#   Webservice endpoint type.
#
# [*class*]
#   Webservice endpoint class.
#
# [*wsdl_url*]
#   Webservice endpoint WSDL URL.
#
# [*name*]
#   Webservice endpoint name.
#
# [*context*]
#   Webservice endpoint context.
#
#
define jboss_admin::endpoint (
  $server,
  $type                           = undef,
  $class                          = undef,
  $wsdl_url                       = undef,
  $name                           = undef,
  $context                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $type == undef { fail('The attribute type is undefined but required') }
    if $class == undef { fail('The attribute class is undefined but required') }
    if $wsdl_url == undef { fail('The attribute wsdl_url is undefined but required') }
    if $name == undef { fail('The attribute name is undefined but required') }
    if $context == undef { fail('The attribute context is undefined but required') }
  

    $raw_options = { 
      'type'                         => $type,
      'class'                        => $class,
      'wsdl-url'                     => $wsdl_url,
      'name'                         => $name,
      'context'                      => $context,
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
