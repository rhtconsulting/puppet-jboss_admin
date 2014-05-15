# == Defines jboss_admin::ldap-connection
#
# A connection factory that can be used by a security realm to access an LDAP server as a source of authentication and authorization information.
#
# === Parameters
#
# [*search_credential*]
#   The credential to use when connecting to perform a search.
#
# [*search_dn*]
#   The distinguished name to use when connecting to the LDAP server to perform searches.
#
# [*url*]
#   The URL to use to connect to the LDAP server.
#
# [*initial_context_factory*]
#   The initial context factory to establish the LdapContext.
#
#
define jboss_admin::resource::ldap-connection (
  $server,
  $search_credential              = undef,
  $search_dn                      = undef,
  $url                            = undef,
  $initial_context_factory        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'search-credential'            => $search_credential,
      'search-dn'                    => $search_dn,
      'url'                          => $url,
      'initial-context-factory'      => $initial_context_factory,
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
