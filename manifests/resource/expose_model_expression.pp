# == Defines jboss_admin::expose_model_expression
#
# The configuration for exposing the 'expression' model controller in the MBeanServer. This facade will expose all simple attributes and operation parameters as String. Reads return the unresolved expression. You may use expressions when writing attributes and setting operation parameters.
#
# === Parameters
#
# [*domain_name*]
#   The domain name to use for the 'expression' model controller JMX facade in the MBeanServer.
#
#
define jboss_admin::resource::expose_model_expression (
  $server,
  $domain_name                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $domain_name != undef and !is_string($domain_name) { 
      fail('The attribute domain_name is not a string') 
    }
  

    $raw_options = { 
      'domain-name'                  => $domain_name,
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
