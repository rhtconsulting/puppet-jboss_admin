# == Defines jboss_admin::connector_web
#
# A web connector.
#
# === Parameters
#
# [*virtual_server*]
#   The list of virtual servers that can be accessed through this connector. The default is to allow all virtual servers.
#
# [*max_connections*]
#   Amount of concurrent connections that can be processed by the connector with optimum performance. The default value depends on the connector used.
#
# [*scheme*]
#   The web connector scheme.
#
# [*max_post_size*]
#   Maximum size in bytes of a POST request that can be parsed by the container.
#
# [*enabled*]
#   Defines whether the connector should be started on startup.
#
# [*socket_binding*]
#   The web connector socket-binding reference, this connector should be bound to.
#
# [*executor*]
#   The name of the executor that should be used for the processing threads of this connector. If undefined defaults to using an internal pool.
#
# [*max_save_post_size*]
#   Maximum size in bytes of a POST request that will be saved during certain authentication schemes.
#
# [*proxy_name*]
#   The host name that will be used when sending a redirect. The default value is null.
#
# [*secure*]
#   Indicates if content sent or received by the connector is secured from the user perspective.
#
# [*enable_lookups*]
#   Enable DNS lookups for Servlet API.
#
# [*redirect_port*]
#   The port for redirection to a secure connector.
#
# [*proxy_port*]
#   The port that will be used when sending a redirect.
#
# [*_name*]
#   A unique name for the connector.
#
# [*protocol*]
#   The web connector protocol.
#
#
define jboss_admin::resource::connector_web (
  $server,
  $virtual_server                 = undef,
  $max_connections                = undef,
  $scheme                         = undef,
  $max_post_size                  = undef,
  $enabled                        = undef,
  $socket_binding                 = undef,
  $executor                       = undef,
  $max_save_post_size             = undef,
  $proxy_name                     = undef,
  $secure                         = undef,
  $enable_lookups                 = undef,
  $redirect_port                  = undef,
  $proxy_port                     = undef,
  $_name                          = undef,
  $protocol                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_connections != undef and !is_integer($max_connections) { 
      fail('The attribute max_connections is not an integer') 
    }
    if $max_post_size != undef and !is_integer($max_post_size) { 
      fail('The attribute max_post_size is not an integer') 
    }
    if $max_save_post_size != undef and !is_integer($max_save_post_size) { 
      fail('The attribute max_save_post_size is not an integer') 
    }
    if $redirect_port != undef and !is_integer($redirect_port) { 
      fail('The attribute redirect_port is not an integer') 
    }
    if $proxy_port != undef and !is_integer($proxy_port) { 
      fail('The attribute proxy_port is not an integer') 
    }
  

    $raw_options = { 
      'virtual-server'               => $virtual_server,
      'max-connections'              => $max_connections,
      'scheme'                       => $scheme,
      'max-post-size'                => $max_post_size,
      'enabled'                      => $enabled,
      'socket-binding'               => $socket_binding,
      'executor'                     => $executor,
      'max-save-post-size'           => $max_save_post_size,
      'proxy-name'                   => $proxy_name,
      'secure'                       => $secure,
      'enable-lookups'               => $enable_lookups,
      'redirect-port'                => $redirect_port,
      'proxy-port'                   => $proxy_port,
      'name'                         => $_name,
      'protocol'                     => $protocol,
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
