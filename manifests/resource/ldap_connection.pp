# == Defines jboss_admin::ldap_connection
#
# A connection factory that can be used by a security realm to access an LDAP server as a source of authentication and authorization information.
#
# === Parameters
#
# [*initial_context_factory*]
#   The initial context factory to establish the LdapContext.
#
# [*search_credential*]
#   The credential to use when connecting to perform a search.
#
# [*url*]
#   The URL to use to connect to the LDAP server.
#
# [*search_dn*]
#   The distinguished name to use when connecting to the LDAP server to perform searches.
#
#
define jboss_admin::resource::ldap_connection (
  $server,
  $initial_context_factory        = undef,
  $search_credential              = undef,
  $url                            = undef,
  $search_dn                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'initial-context-factory'      => $initial_context_factory,
      'search-credential'            => $search_credential,
      'url'                          => $url,
      'search-dn'                    => $search_dn,
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
