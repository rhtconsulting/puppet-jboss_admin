# == Defines jboss_admin::subsystem
#
# A subsystem provided by the extension. What is provided here is information about the xml schema and management interface provided by the subsystem, not the configuration of the subsystem itself.
#
# === Parameters
#
# [*xml_namespaces*]
#   A list of URIs for the XML namespaces supported by the subsystem's XML parser. May be empty if the extension did not clearly associate an XML namespace with a particular subsystem.
#
# [*management_major_version*]
#   Major version of the subsystem's management interface. May be undefined if the subsystem does not currently provide a versioned management interface.
#
# [*management_minor_version*]
#   Minor version of the subsystem's management interface. May be undefined if the subsystem does not currently provide a versioned management interface.
#
#
define jboss_admin::resource::subsystem (
  $server,
  $xml_namespaces                 = undef,
  $management_major_version       = undef,
  $management_minor_version       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $management_major_version != undef and !is_integer($management_major_version) { 
      fail('The attribute management_major_version is not an integer') 
    }
    if $management_minor_version != undef and !is_integer($management_minor_version) { 
      fail('The attribute management_minor_version is not an integer') 
    }
  

    $raw_options = { 
      'xml-namespaces'               => $xml_namespaces,
      'management-major-version'     => $management_major_version,
      'management-minor-version'     => $management_minor_version,
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
