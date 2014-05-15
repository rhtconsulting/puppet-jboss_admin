# == Defines jboss_admin::configuration_jsp-configuration
#
# JSP container configuration.
#
# === Parameters
#
# [*display_source_fragment*]
#   When a runtime error occurs, attempts to display corresponding JSP source fragment.
#
# [*smap*]
#   Enable SMAP.
#
# [*keep_generated*]
#   Keep the generated Servlets.
#
# [*x_powered_by*]
#   Enable advertising the JSP engine in x-powered-by.
#
# [*error_on_use_bean_invalid_class_attribute*]
#   Enable errors when using a bad class in useBean.
#
# [*recompile_on_fail*]
#   Retry failed JSP compilations on each request.
#
# [*dump_smap*]
#   Write SMAP data to a file.
#
# [*java_encoding*]
#   Specify the encoding used for Java sources.
#
# [*check_interval*]
#   Check interval for JSP updates using a background thread.
#
# [*mapped_file*]
#   Map to the JSP source.
#
# [*tag_pooling*]
#   Enable tag pooling.
#
# [*development*]
#   Enable the development mode, which gives more information when an error occurs.
#
# [*modification_test_interval*]
#   Minimum amount of time between two tests for updates, in seconds.
#
# [*trim_spaces*]
#   Trim some spaces from the generated Servlet.
#
# [*generate_strings_as_char_arrays*]
#   Generate String constants as char arrays.
#
# [*disabled*]
#   Enable the JSP container.
#
# [*scratch_dir*]
#   Specify a different work directory.
#
# [*source_vm*]
#   Source VM level for compilation.
#
# [*target_vm*]
#   Target VM level for compilation.
#
#
define jboss_admin::resource::configuration_jsp-configuration (
  $server,
  $display_source_fragment        = undef,
  $smap                           = undef,
  $keep_generated                 = undef,
  $x_powered_by                   = undef,
  $error_on_use_bean_invalid_class_attribute = undef,
  $recompile_on_fail              = undef,
  $dump_smap                      = undef,
  $java_encoding                  = undef,
  $check_interval                 = undef,
  $mapped_file                    = undef,
  $tag_pooling                    = undef,
  $development                    = undef,
  $modification_test_interval     = undef,
  $trim_spaces                    = undef,
  $generate_strings_as_char_arrays = undef,
  $disabled                       = undef,
  $scratch_dir                    = undef,
  $source_vm                      = undef,
  $target_vm                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $check_interval != undef and !is_integer($check_interval) { 
      fail('The attribute check_interval is not an integer') 
    }
    if $modification_test_interval != undef and !is_integer($modification_test_interval) { 
      fail('The attribute modification_test_interval is not an integer') 
    }
  

    $raw_options = { 
      'display-source-fragment'      => $display_source_fragment,
      'smap'                         => $smap,
      'keep-generated'               => $keep_generated,
      'x-powered-by'                 => $x_powered_by,
      'error-on-use-bean-invalid-class-attribute' => $error_on_use_bean_invalid_class_attribute,
      'recompile-on-fail'            => $recompile_on_fail,
      'dump-smap'                    => $dump_smap,
      'java-encoding'                => $java_encoding,
      'check-interval'               => $check_interval,
      'mapped-file'                  => $mapped_file,
      'tag-pooling'                  => $tag_pooling,
      'development'                  => $development,
      'modification-test-interval'   => $modification_test_interval,
      'trim-spaces'                  => $trim_spaces,
      'generate-strings-as-char-arrays' => $generate_strings_as_char_arrays,
      'disabled'                     => $disabled,
      'scratch-dir'                  => $scratch_dir,
      'source-vm'                    => $source_vm,
      'target-vm'                    => $target_vm,
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
