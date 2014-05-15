# == Defines jboss_admin::connector_remoting
#
# The configuration of a Remoting connector.
#
# === Parameters
#
# [*security_realm*]
#   The associated security realm to use for authentication for this connector.
#
# [*socket_binding*]
#   The name (or names) of the socket binding(s) to attach to.
#
# [*authentication_provider*]
#   The "authentication-provider" element contains the name of the authentication provider to use for incoming connections.
#
#
define jboss_admin::resource::connector_remoting (
  $server,
  $security_realm                 = undef,
  $socket_binding                 = undef,
  $authentication_provider        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'security-realm'               => $security_realm,
      'socket-binding'               => $socket_binding,
      'authentication-provider'      => $authentication_provider,
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
