# == Defines jboss_admin::subsystem
#
# A subsystem provided by the extension. What is provided here is information about the xml schema and management interface provided by the subsystem, not the configuration of the subsystem itself.
#
# === Parameters
#
# [*management_major_version*]
#   Major version of the subsystem's management interface. May be undefined if the subsystem does not currently provide a versioned management interface.
#
# [*management_micro_version*]
#   Micro version of the subsystem's management interface. May be undefined if the subsystem does not currently provide a versioned management interface.
#
# [*management_minor_version*]
#   Minor version of the subsystem's management interface. May be undefined if the subsystem does not currently provide a versioned management interface.
#
# [*xml_namespaces*]
#   A list of URIs for the XML namespaces supported by the subsystem's XML parser. May be empty if the extension did not clearly associate an XML namespace with a particular subsystem.
#
#
define jboss_admin::resource::subsystem (
  $server,
  $management_major_version       = undef,
  $management_micro_version       = undef,
  $management_minor_version       = undef,
  $xml_namespaces                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $management_major_version != undef and $management_major_version != undefined and !is_integer($management_major_version) {
      fail('The attribute management_major_version is not an integer')
    }
    if $management_micro_version != undef and $management_micro_version != undefined and !is_integer($management_micro_version) {
      fail('The attribute management_micro_version is not an integer')
    }
    if $management_minor_version != undef and $management_minor_version != undefined and !is_integer($management_minor_version) {
      fail('The attribute management_minor_version is not an integer')
    }
    if $xml_namespaces != undef and $xml_namespaces != undefined and !is_array($xml_namespaces) {
      fail('The attribute xml_namespaces is not an array')
    }

    $raw_options = {
      'management-major-version'     => $management_major_version,
      'management-micro-version'     => $management_micro_version,
      'management-minor-version'     => $management_minor_version,
      'xml-namespaces'               => $xml_namespaces,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
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
