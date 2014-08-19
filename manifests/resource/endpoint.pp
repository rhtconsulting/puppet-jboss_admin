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
# [*context*]
#   Webservice endpoint context.
#
# [*resource_name*]
#   Webservice endpoint name.
#
#
define jboss_admin::resource::endpoint (
  $server,
  $type                           = undef,
  $class                          = undef,
  $wsdl_url                       = undef,
  $context                        = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $type == undef { fail('The attribute type is undefined but required') }
    if $class == undef { fail('The attribute class is undefined but required') }
    if $wsdl_url == undef { fail('The attribute wsdl_url is undefined but required') }
    if $context == undef { fail('The attribute context is undefined but required') }
    if $resource_name == undef { fail('The attribute resource_name is undefined but required') }
  

    $raw_options = { 
      'type'                         => $type,
      'class'                        => $class,
      'wsdl-url'                     => $wsdl_url,
      'context'                      => $context,
      'name'                         => $resource_name,
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
