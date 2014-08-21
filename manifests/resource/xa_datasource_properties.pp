# == Defines jboss_admin::xa_datasource_properties
#
# List of xa-datasource-property
#
# === Parameters
#
# [*value*]
#   Specifies a property value to assign to the XADataSource implementation class. Each property is identified by the name attribute and the property value is given by the xa-datasource-property element content. The property is mapped onto the XADataSource implementation by looking for a JavaBeans style getter method for the property name. If found, the value of the property is set using the JavaBeans setter with the element text translated to the true property type using the java.beans.PropertyEditor
#
#
define jboss_admin::resource::xa_datasource_properties (
  $server,
  $value                          = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $value != undef and !is_string($value) { 
      fail('The attribute value is not a string') 
    }
  

    $raw_options = { 
      'value'                        => $value,
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
