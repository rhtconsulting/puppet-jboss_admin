# == Defines jboss_admin::ldap_connection
#
# A connection factory that can be used by a security realm to access an LDAP server as a source of authentication and authorization information.
#
# === Parameters
#
# [*handles_referrals_for*]
#   List of URLs that this connection handles referrals for.
#
# [*initial_context_factory*]
#   The initial context factory to establish the LdapContext.
#
# [*referrals*]
#   The referral handling mode for this connection.
#
# [*search_credential*]
#   The credential to use when connecting to perform a search.
#
# [*search_dn*]
#   The distinguished name to use when connecting to the LDAP server to perform searches.
#
# [*security_realm*]
#   The security realm to reference to obtain a configured SSLContext to use when establishing the connection.
#
# [*url*]
#   The URL to use to connect to the LDAP server.
#
#
define jboss_admin::resource::ldap_connection (
  $server,
  $handles_referrals_for          = undef,
  $initial_context_factory        = undef,
  $referrals                      = undef,
  $search_credential              = undef,
  $search_dn                      = undef,
  $security_realm                 = undef,
  $url                            = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $handles_referrals_for != undef and $handles_referrals_for != undefined and !is_array($handles_referrals_for) {
      fail('The attribute handles_referrals_for is not an array')
    }
    if $referrals != undef and $referrals != undefined and !($referrals in ['FOLLOW','IGNORE','THROW']) {
      fail('The attribute referrals is not an allowed value: "FOLLOW","IGNORE","THROW"')
    }

    $raw_options = {
      'handles-referrals-for'        => $handles_referrals_for,
      'initial-context-factory'      => $initial_context_factory,
      'referrals'                    => $referrals,
      'search-credential'            => $search_credential,
      'search-dn'                    => $search_dn,
      'security-realm'               => $security_realm,
      'url'                          => $url,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }
}
