# == Defines jboss_admin::type_runtime
#
# The management interface for the runtime system of the Java virtual machine.
#
# === Parameters
#
# [*vm_vendor*]
#   The Java virtual machine implementation vendor. If a security manager is installed and it does not allow access to system property "java.vm.vendor", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*start_time*]
#   The start time of the Java virtual machine in milliseconds.
#
# [*class_path*]
#   The Java class path that is used by the system class loader to search for class files. If a security manager is installed and it does not allow access to system property "java.class.path", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*vm_version*]
#   The Java virtual machine implementation version. If a security manager is installed and it does not allow access to system property "java.vm.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*system_properties*]
#   A map of names and values of all system properties. If a security manager is installed and its "checkPropertiesAccess" method does not allow access to system properties, then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*object_name*]
#   String representation the object name of this platform managed object.
#
# [*library_path*]
#   The Java library path. If a security manager is installed and it does not allow access to system property "java.library.path", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*spec_name*]
#   The Java virtual machine specification name. If a security manager is installed and it does not allow access to system property "java.vm.specification.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*boot_class_path_supported*]
#   Whether the Java virtual machine supports the boot class path mechanism used by the bootstrap class loader to search for class files.
#
# [*spec_vendor*]
#   The Java virtual machine specification vendor. If a security manager is installed and it does not allow access to system property "java.vm.specification.vendor", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*boot_class_path*]
#   The boot class path that is used by the bootstrap class loader to search for class files. If attribute "boot-class-path-supported" is "false" or if a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*resource_name*]
#   The name representing the running Java virtual machine.
#
# [*spec_version*]
#   The Java virtual machine specification version. If a security manager is installed and it does not allow access to system property "java.vm.specification.version", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*vm_name*]
#   The Java virtual machine implementation name. If a security manager is installed and it does not allow access to system property "java.vm.name", then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*input_arguments*]
#   The input arguments passed to the Java virtual machine which does not include the arguments to the main method. If a security manager is installed and the caller does not have ManagementPermission("monitor"), then a "read-attribute" operation reading this attribute will fail, and the value for this attribute in the result for the "read-resource" operation will be "undefined".
#
# [*management_spec_version*]
#   The version of the specification for the management interface implemented by the running Java virtual machine.
#
#
define jboss_admin::resource::type_runtime (
  $server,
  $vm_vendor                      = undef,
  $start_time                     = undef,
  $class_path                     = undef,
  $vm_version                     = undef,
  $system_properties              = undef,
  $object_name                    = undef,
  $library_path                   = undef,
  $spec_name                      = undef,
  $boot_class_path_supported      = undef,
  $spec_vendor                    = undef,
  $boot_class_path                = undef,
  $resource_name                  = undef,
  $spec_version                   = undef,
  $vm_name                        = undef,
  $input_arguments                = undef,
  $management_spec_version        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'vm-vendor'                    => $vm_vendor,
      'start-time'                   => $start_time,
      'class-path'                   => $class_path,
      'vm-version'                   => $vm_version,
      'system-properties'            => $system_properties,
      'object-name'                  => $object_name,
      'library-path'                 => $library_path,
      'spec-name'                    => $spec_name,
      'boot-class-path-supported'    => $boot_class_path_supported,
      'spec-vendor'                  => $spec_vendor,
      'boot-class-path'              => $boot_class_path,
      'name'                         => $resource_name,
      'spec-version'                 => $spec_version,
      'vm-name'                      => $vm_name,
      'input-arguments'              => $input_arguments,
      'management-spec-version'      => $management_spec_version,
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
