# == Defines jboss_admin::subsystem_webservices
#
# The configuration of the web services subsystem.
#
# === Parameters
#
# [*modify_wsdl_address*]
#   Whether the soap address can be modified.
#
# [*wsdl_host*]
#   The WSDL, that is a required deployment artifact for an endpoint, has a <soap:address> element which points to the location of the endpoint. JBoss supports rewriting of that SOAP address. If the content of <soap:address> is a valid URL, JBossWS will not rewrite it unless 'modify-wsdl-address' is true. If the content of <soap:address> is not a valid URL, JBossWS will rewrite it using the attribute values given below. If 'wsdl-host' is set to 'jbossws.undefined.host', JBossWS uses requesters host when rewriting the <soap:address>
#
# [*wsdl_port*]
#   The non-secure port that will be used for rewriting the SOAP address. If absent the port will be identified by querying the list of installed connectors.
#
# [*wsdl_secure_port*]
#   The secure port that will be used for rewriting the SOAP address. If absent the port will be identified by querying the list of installed connectors.
#
#
define jboss_admin::resource::subsystem_webservices (
  $server,
  $modify_wsdl_address            = undef,
  $wsdl_host                      = undef,
  $wsdl_port                      = undef,
  $wsdl_secure_port               = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $modify_wsdl_address != undef and $modify_wsdl_address != undefined {
      validate_bool($modify_wsdl_address)
    }
    if $wsdl_port != undef and $wsdl_port != undefined and !is_integer($wsdl_port) {
      fail('The attribute wsdl_port is not an integer')
    }
    if $wsdl_secure_port != undef and $wsdl_secure_port != undefined and !is_integer($wsdl_secure_port) {
      fail('The attribute wsdl_secure_port is not an integer')
    }

    $raw_options = {
      'modify-wsdl-address'          => $modify_wsdl_address,
      'wsdl-host'                    => $wsdl_host,
      'wsdl-port'                    => $wsdl_port,
      'wsdl-secure-port'             => $wsdl_secure_port,
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
