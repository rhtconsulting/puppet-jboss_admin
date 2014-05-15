# == Defines jboss_admin::endpoint
#
# Webservice endpoint.
#
# === Parameters
#
# [*context*]
#   Webservice endpoint context.
#
# [*type*]
#   Webservice endpoint type.
#
# [*class*]
#   Webservice endpoint class.
#
# [*name*]
#   Webservice endpoint name.
#
# [*wsdl_url*]
#   Webservice endpoint WSDL URL.
#
#
define jboss_admin::resource::endpoint (
  $server,
  $context                        = undef,
  $type                           = undef,
  $class                          = undef,
  $name                           = undef,
  $wsdl_url                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $context == undef { fail('The attribute context is undefined but required') }
    if $type == undef { fail('The attribute type is undefined but required') }
    if $class == undef { fail('The attribute class is undefined but required') }
    if $name == undef { fail('The attribute name is undefined but required') }
    if $wsdl_url == undef { fail('The attribute wsdl_url is undefined but required') }
  

    $raw_options = { 
      'context'                      => $context,
      'type'                         => $type,
      'class'                        => $class,
      'name'                         => $name,
      'wsdl-url'                     => $wsdl_url,
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
