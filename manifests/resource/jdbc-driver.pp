# == Defines jboss_admin::jdbc-driver
#
# A service that makes a JDBC driver available for use in the runtime
#
# === Parameters
#
# [*driver_major_version*]
#   The driver's major version number
#
# [*driver_name*]
#   The symbolic name of this driver used to reference it in the registry
#
# [*driver_module_name*]
#   The name of the module from which the driver was loaded, if it was loaded from the module path
#
# [*driver_minor_version*]
#   The driver's minor version number
#
# [*module_slot*]
#   The slot of the module from which the driver was loaded, if it was loaded from the module path
#
# [*jdbc_compliant*]
#   Whether or not the driver is JDBC compliant
#
# [*driver_class_name*]
#   The fully qualified class name of the java.sql.Driver implementation
#
# [*xa_datasource_class*]
#   The fully qualified class name of the javax.sql.XADataSource implementation
#
# [*deployment_name*]
#   The name of the deployment unit from which the driver was loaded
#
#
define jboss_admin::resource::jdbc-driver (
  $server,
  $driver_major_version           = undef,
  $driver_name                    = undef,
  $driver_module_name             = undef,
  $driver_minor_version           = undef,
  $module_slot                    = undef,
  $jdbc_compliant                 = undef,
  $driver_class_name              = undef,
  $xa_datasource_class            = undef,
  $deployment_name                = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $driver_major_version != undef and !is_integer($driver_major_version) { 
      fail('The attribute driver_major_version is not an integer') 
    }
    if $driver_name == undef { fail('The attribute driver_name is undefined but required') }
    if $driver_minor_version != undef and !is_integer($driver_minor_version) { 
      fail('The attribute driver_minor_version is not an integer') 
    }
  

    $raw_options = { 
      'driver-major-version'         => $driver_major_version,
      'driver-name'                  => $driver_name,
      'driver-module-name'           => $driver_module_name,
      'driver-minor-version'         => $driver_minor_version,
      'module-slot'                  => $module_slot,
      'jdbc-compliant'               => $jdbc_compliant,
      'driver-class-name'            => $driver_class_name,
      'xa-datasource-class'          => $xa_datasource_class,
      'deployment-name'              => $deployment_name,
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
