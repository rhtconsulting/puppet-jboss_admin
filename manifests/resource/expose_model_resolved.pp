# == Defines jboss_admin::expose_model_resolved
#
# The configuration for exposing the 'resolved' model controller in the MBeanServer. This facade will expose all simple attributes and operation parameters as their type in the underlying model. Reads return the resolved expression if used, or the raw value. You may not use expressions when writing attributes and setting operation parameters.
#
# === Parameters
#
# [*domain_name*]
#   The domain name to use for the 'resolved' model controller JMX facade in the MBeanServer.
#
# [*proper_property_format*]
#   If false, PROPERTY type attributes are represented as a DMR string, this is the legacy behaviour. If true, PROPERTY type attributes are represented by a composite type where the key is a string, and the value has the same type as the property in the underlying model.
#
#
define jboss_admin::resource::expose_model_resolved (
  $server,
  $domain_name                    = undef,
  $proper_property_format         = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $proper_property_format != undef {
      validate_bool($proper_property_format)
    }
  

    $raw_options = {
      'domain-name'                  => $domain_name,
      'proper-property-format'       => $proper_property_format,
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
