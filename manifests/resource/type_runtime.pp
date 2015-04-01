# == Defines jboss_admin::type_runtime
#
# The management interface for the runtime system of the Java virtual machine.
#
# === Parameters
#
# [*boot_class_path*]
#   The boot class path that is used by the bootstrap class loader to search for class files. If attribute "boot-class-path-supported" is "false" or if a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*boot_class_path_supported*]
#   Whether the Java virtual machine supports the boot class path mechanism used by the bootstrap class loader to search for class files.
#
# [*class_path*]
#   The Java class path that is used by the system class loader to search for class files. If a security manager is installed and it does not allow access to system property "java.class.path", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*input_arguments*]
#   The input arguments passed to the Java virtual machine which does not include the arguments to the main method. If a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*library_path*]
#   The Java library path. If a security manager is installed and it does not allow access to system property "java.library.path", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*management_spec_version*]
#   The version of the specification for the management interface implemented by the running Java virtual machine.
#
# [*resource_name*]
#   The name representing the running Java virtual machine.
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*spec_name*]
#   The Java virtual machine specification name. If a security manager is installed and it does not allow access to system property "java.vm.specification.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*spec_vendor*]
#   The Java virtual machine specification vendor. If a security manager is installed and it does not allow access to system property "java.vm.specification.vendor", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*spec_version*]
#   The Java virtual machine specification version. If a security manager is installed and it does not allow access to system property "java.vm.specification.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*start_time*]
#   The start time of the Java virtual machine in milliseconds.
#
# [*system_properties*]
#   A map of names and values of all system properties. If a security manager is installed and its "checkPropertiesAccess" method does not allow access to system properties, then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*vm_name*]
#   The Java virtual machine implementation name. If a security manager is installed and it does not allow access to system property "java.vm.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*vm_vendor*]
#   The Java virtual machine implementation vendor. If a security manager is installed and it does not allow access to system property "java.vm.vendor", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*vm_version*]
#   The Java virtual machine implementation version. If a security manager is installed and it does not allow access to system property "java.vm.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
#
define jboss_admin::resource::type_runtime (
  $server,
  $boot_class_path                = undef,
  $boot_class_path_supported      = undef,
  $class_path                     = undef,
  $input_arguments                = undef,
  $library_path                   = undef,
  $management_spec_version        = undef,
  $resource_name                  = undef,
  $object_name                    = undef,
  $spec_name                      = undef,
  $spec_vendor                    = undef,
  $spec_version                   = undef,
  $start_time                     = undef,
  $system_properties              = undef,
  $vm_name                        = undef,
  $vm_vendor                      = undef,
  $vm_version                     = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $boot_class_path_supported != undef { 
      validate_bool($boot_class_path_supported)
    }
    if $input_arguments != undef and !is_array($input_arguments) { 
      fail('The attribute input_arguments is not an array') 
    }
    if $start_time != undef and !is_integer($start_time) { 
      fail('The attribute start_time is not an integer') 
    }
  

    $raw_options = { 
      'boot-class-path'              => $boot_class_path,
      'boot-class-path-supported'    => $boot_class_path_supported,
      'class-path'                   => $class_path,
      'input-arguments'              => $input_arguments,
      'library-path'                 => $library_path,
      'management-spec-version'      => $management_spec_version,
      'name'                         => $resource_name,
      'object-name'                  => $object_name,
      'spec-name'                    => $spec_name,
      'spec-vendor'                  => $spec_vendor,
      'spec-version'                 => $spec_version,
      'start-time'                   => $start_time,
      'system-properties'            => $system_properties,
      'vm-name'                      => $vm_name,
      'vm-vendor'                    => $vm_vendor,
      'vm-version'                   => $vm_version,
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
