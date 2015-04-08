# == Defines jboss_admin::connector_web
#
# A web connector.
#
# === Parameters
#
# [*enable_lookups*]
#   Enable DNS lookups for Servlet API.
#
# [*enabled*]
#   Defines whether the connector should be started on startup.
#
# [*executor*]
#   The name of the executor that should be used for the processing threads of this connector. If undefined defaults to using an internal pool.
#
# [*max_connections*]
#   Amount of concurrent connections that can be processed by the connector with optimum performance. The default value depends on the connector used.
#
# [*max_post_size*]
#   Maximum size in bytes of a POST request that can be parsed by the container.
#
# [*max_save_post_size*]
#   Maximum size in bytes of a POST request that will be saved during certain authentication schemes.
#
# [*resource_name*]
#   A unique name for the connector.
#
# [*protocol*]
#   The web connector protocol.
#
# [*proxy_name*]
#   The host name that will be used when sending a redirect. The default value is null.
#
# [*proxy_port*]
#   The port that will be used when sending a redirect.
#
# [*redirect_port*]
#   The port for redirection to a secure connector.
#
# [*scheme*]
#   The web connector scheme.
#
# [*secure*]
#   Indicates if content sent or received by the connector is secured from the user perspective.
#
# [*socket_binding*]
#   The web connector socket-binding reference, this connector should be bound to.
#
# [*virtual_server*]
#   The list of virtual servers that can be accessed through this connector. The default is to allow all virtual servers.
#
#
define jboss_admin::resource::connector_web (
  $server,
  $enable_lookups                 = undef,
  $enabled                        = undef,
  $executor                       = undef,
  $max_connections                = undef,
  $max_post_size                  = undef,
  $max_save_post_size             = undef,
  $resource_name                  = undef,
  $protocol                       = undef,
  $proxy_name                     = undef,
  $proxy_port                     = undef,
  $redirect_port                  = undef,
  $scheme                         = undef,
  $secure                         = undef,
  $socket_binding                 = undef,
  $virtual_server                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_connections != undef and $max_connections != undefined and !is_integer($max_connections) {
      fail('The attribute max_connections is not an integer')
    }
    if $max_post_size != undef and $max_post_size != undefined and !is_integer($max_post_size) {
      fail('The attribute max_post_size is not an integer')
    }
    if $max_save_post_size != undef and $max_save_post_size != undefined and !is_integer($max_save_post_size) {
      fail('The attribute max_save_post_size is not an integer')
    }
    if $proxy_port != undef and $proxy_port != undefined and !is_integer($proxy_port) {
      fail('The attribute proxy_port is not an integer')
    }
    if $redirect_port != undef and $redirect_port != undefined and !is_integer($redirect_port) {
      fail('The attribute redirect_port is not an integer')
    }
  

    $raw_options = {
      'enable-lookups'               => $enable_lookups,
      'enabled'                      => $enabled,
      'executor'                     => $executor,
      'max-connections'              => $max_connections,
      'max-post-size'                => $max_post_size,
      'max-save-post-size'           => $max_save_post_size,
      'name'                         => $resource_name,
      'protocol'                     => $protocol,
      'proxy-name'                   => $proxy_name,
      'proxy-port'                   => $proxy_port,
      'redirect-port'                => $redirect_port,
      'scheme'                       => $scheme,
      'secure'                       => $secure,
      'socket-binding'               => $socket_binding,
      'virtual-server'               => $virtual_server,
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
