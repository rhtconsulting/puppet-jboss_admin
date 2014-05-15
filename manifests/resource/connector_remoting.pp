# == Defines jboss_admin::connector_remoting
#
# The configuration of a Remoting connector.
#
# === Parameters
#
# [*socket_binding*]
#   The name (or names) of the socket binding(s) to attach to.
#
# [*authentication_provider*]
#   The "authentication-provider" element contains the name of the authentication provider to use for incoming connections.
#
# [*security_realm*]
#   The associated security realm to use for authentication for this connector.
#
#
define jboss_admin::resource::connector_remoting (
  $server,
  $socket_binding                 = undef,
  $authentication_provider        = undef,
  $security_realm                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'socket-binding'               => $socket_binding,
      'authentication-provider'      => $authentication_provider,
      'security-realm'               => $security_realm,
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
