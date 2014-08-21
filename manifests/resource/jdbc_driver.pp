# == Defines jboss_admin::jdbc_driver
#
# Service that make a JDBC driver available for use in the runtime
#
# === Parameters
#
# [*deployment_name*]
#   The name of the deployment unit from which the driver was loaded
#
# [*driver_class_name*]
#   The fully qualified class name of the java.sql.Driver implementation
#
# [*driver_datasource_class_name*]
#   The fully qualified class name of the javax.sql.DataSource implementation
#
# [*driver_major_version*]
#   The driver's major version number
#
# [*driver_minor_version*]
#   The driver's minor version number
#
# [*driver_module_name*]
#   The name of the module from which the driver was loaded, if it was loaded from the module path
#
# [*driver_name*]
#   Defines the JDBC driver the datasource should use. It is a symbolic name matching the the name of installed driver. In case the driver is deployed as jar, the name is the name of deployment unit
#
# [*driver_xa_datasource_class_name*]
#   The fully qualified class name of the javax.sql.XADataSource implementation
#
# [*jdbc_compliant*]
#   Whether or not the driver is JDBC compliant
#
# [*module_slot*]
#   The slot of the module from which the driver was loaded, if it was loaded from the module path
#
# [*xa_datasource_class*]
#   XA datasource class
#
#
define jboss_admin::resource::jdbc_driver (
  $server,
  $deployment_name                = undef,
  $driver_class_name              = undef,
  $driver_datasource_class_name   = undef,
  $driver_major_version           = undef,
  $driver_minor_version           = undef,
  $driver_module_name             = undef,
  $driver_name                    = undef,
  $driver_xa_datasource_class_name = undef,
  $jdbc_compliant                 = undef,
  $module_slot                    = undef,
  $xa_datasource_class            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $deployment_name != undef and !is_string($deployment_name) { 
      fail('The attribute deployment_name is not a string') 
    }
    if $driver_class_name != undef and !is_string($driver_class_name) { 
      fail('The attribute driver_class_name is not a string') 
    }
    if $driver_datasource_class_name != undef and !is_string($driver_datasource_class_name) { 
      fail('The attribute driver_datasource_class_name is not a string') 
    }
    if $driver_major_version != undef and !is_integer($driver_major_version) { 
      fail('The attribute driver_major_version is not an integer') 
    }
    if $driver_minor_version != undef and !is_integer($driver_minor_version) { 
      fail('The attribute driver_minor_version is not an integer') 
    }
    if $driver_module_name != undef and !is_string($driver_module_name) { 
      fail('The attribute driver_module_name is not a string') 
    }
    if $driver_name != undef and !is_string($driver_name) { 
      fail('The attribute driver_name is not a string') 
    }
    if $driver_xa_datasource_class_name != undef and !is_string($driver_xa_datasource_class_name) { 
      fail('The attribute driver_xa_datasource_class_name is not a string') 
    }
    if $jdbc_compliant != undef and !is_bool($jdbc_compliant) { 
      fail('The attribute jdbc_compliant is not a boolean') 
    }
    if $module_slot != undef and !is_string($module_slot) { 
      fail('The attribute module_slot is not a string') 
    }
    if $xa_datasource_class != undef and !is_string($xa_datasource_class) { 
      fail('The attribute xa_datasource_class is not a string') 
    }
  

    $raw_options = { 
      'deployment-name'              => $deployment_name,
      'driver-class-name'            => $driver_class_name,
      'driver-datasource-class-name' => $driver_datasource_class_name,
      'driver-major-version'         => $driver_major_version,
      'driver-minor-version'         => $driver_minor_version,
      'driver-module-name'           => $driver_module_name,
      'driver-name'                  => $driver_name,
      'driver-xa-datasource-class-name' => $driver_xa_datasource_class_name,
      'jdbc-compliant'               => $jdbc_compliant,
      'module-slot'                  => $module_slot,
      'xa-datasource-class'          => $xa_datasource_class,
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
