# == Defines jboss_admin::endpoint
#
# Webservice endpoint.
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
  $path                           = $name
) {
  if $ensure == present {

    if $class == undef { fail('The attribute class is undefined but required') }
    if $context == undef { fail('The attribute context is undefined but required') }
    if $resource_name == undef { fail('The attribute resource_name is undefined but required') }
    if $type == undef { fail('The attribute type is undefined but required') }
    if $wsdl_url == undef { fail('The attribute wsdl_url is undefined but required') }
  

    $raw_options = { 
      'class'                        => $class,
      'context'                      => $context,
      'name'                         => $resource_name,
      'type'                         => $type,
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
