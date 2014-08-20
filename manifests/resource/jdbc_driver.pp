# == Defines jboss_admin::jdbc_driver
#
# A service that makes a JDBC driver available for use in the runtime
#
# === Parameters
#
# [*deployment_name*]
#   The name of the deployment unit from which the driver was loaded
#
# [*driver_class_name*]
#   The fully qualified class name of the java.sql.Driver implementation
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
#   The symbolic name of this driver used to reference it in the registry
#
# [*jdbc_compliant*]
#   Whether or not the driver is JDBC compliant
#
# [*module_slot*]
#   The slot of the module from which the driver was loaded, if it was loaded from the module path
#
# [*xa_datasource_class*]
#   The fully qualified class name of the javax.sql.XADataSource implementation
#
#
define jboss_admin::resource::jdbc_driver (
  $server,
  $deployment_name                = undef,
  $driver_class_name              = undef,
  $driver_major_version           = undef,
  $driver_minor_version           = undef,
  $driver_module_name             = undef,
  $driver_name                    = undef,
  $jdbc_compliant                 = undef,
  $module_slot                    = undef,
  $xa_datasource_class            = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $driver_major_version != undef and !is_integer($driver_major_version) { 
      fail('The attribute driver_major_version is not an integer') 
    }
    if $driver_minor_version != undef and !is_integer($driver_minor_version) { 
      fail('The attribute driver_minor_version is not an integer') 
    }
    if $driver_name == undef { fail('The attribute driver_name is undefined but required') }
  

    $raw_options = { 
      'deployment-name'              => $deployment_name,
      'driver-class-name'            => $driver_class_name,
      'driver-major-version'         => $driver_major_version,
      'driver-minor-version'         => $driver_minor_version,
      'driver-module-name'           => $driver_module_name,
      'driver-name'                  => $driver_name,
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
