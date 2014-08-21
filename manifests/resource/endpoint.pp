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
  $path                           = $name
) {
  if $ensure == present {

    if $class != undef and !is_string($class) { 
      fail('The attribute class is not a string') 
    }
    if $context != undef and !is_string($context) { 
      fail('The attribute context is not a string') 
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
    if $type != undef and !is_string($type) { 
      fail('The attribute type is not a string') 
    }
    if $wsdl_url != undef and !is_string($wsdl_url) { 
      fail('The attribute wsdl_url is not a string') 
    }
  

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
