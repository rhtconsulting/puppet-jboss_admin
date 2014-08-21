# == Defines jboss_admin::configuration_jsp_configuration
#
# JSP container configuration.
#
# === Parameters
#
# [*check_interval*]
#   Check interval for JSP updates using a background thread.
#
# [*development*]
#   Enable the development mode, which gives more information when an error occurs.
#
# [*disabled*]
#   Enable the JSP container.
#
# [*display_source_fragment*]
#   When a runtime error occurs, attempts to display corresponding JSP source fragment.
#
# [*dump_smap*]
#   Write SMAP data to a file.
#
# [*error_on_use_bean_invalid_class_attribute*]
#   Enable errors when using a bad class in useBean.
#
# [*generate_strings_as_char_arrays*]
#   Generate String constants as char arrays.
#
# [*java_encoding*]
#   Specify the encoding used for Java sources.
#
# [*keep_generated*]
#   Keep the generated Servlets.
#
# [*mapped_file*]
#   Map to the JSP source.
#
# [*modification_test_interval*]
#   Minimum amount of time between two tests for updates, in seconds.
#
# [*recompile_on_fail*]
#   Retry failed JSP compilations on each request.
#
# [*scratch_dir*]
#   Specify a different work directory.
#
# [*smap*]
#   Enable SMAP.
#
# [*source_vm*]
#   Source VM level for compilation.
#
# [*tag_pooling*]
#   Enable tag pooling.
#
# [*target_vm*]
#   Target VM level for compilation.
#
# [*trim_spaces*]
#   Trim some spaces from the generated Servlet.
#
# [*x_powered_by*]
#   Enable advertising the JSP engine in x-powered-by.
#
#
define jboss_admin::resource::configuration_jsp_configuration (
  $server,
  $check_interval                 = undef,
  $development                    = undef,
  $disabled                       = undef,
  $display_source_fragment        = undef,
  $dump_smap                      = undef,
  $error_on_use_bean_invalid_class_attribute = undef,
  $generate_strings_as_char_arrays = undef,
  $java_encoding                  = undef,
  $keep_generated                 = undef,
  $mapped_file                    = undef,
  $modification_test_interval     = undef,
  $recompile_on_fail              = undef,
  $scratch_dir                    = undef,
  $smap                           = undef,
  $source_vm                      = undef,
  $tag_pooling                    = undef,
  $target_vm                      = undef,
  $trim_spaces                    = undef,
  $x_powered_by                   = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $check_interval != undef and !is_integer($check_interval) { 
      fail('The attribute check_interval is not an integer') 
    }
    if $development != undef and !is_bool($development) { 
      fail('The attribute development is not a boolean') 
    }
    if $disabled != undef and !is_bool($disabled) { 
      fail('The attribute disabled is not a boolean') 
    }
    if $display_source_fragment != undef and !is_bool($display_source_fragment) { 
      fail('The attribute display_source_fragment is not a boolean') 
    }
    if $dump_smap != undef and !is_bool($dump_smap) { 
      fail('The attribute dump_smap is not a boolean') 
    }
    if $error_on_use_bean_invalid_class_attribute != undef and !is_bool($error_on_use_bean_invalid_class_attribute) { 
      fail('The attribute error_on_use_bean_invalid_class_attribute is not a boolean') 
    }
    if $generate_strings_as_char_arrays != undef and !is_bool($generate_strings_as_char_arrays) { 
      fail('The attribute generate_strings_as_char_arrays is not a boolean') 
    }
    if $java_encoding != undef and !is_string($java_encoding) { 
      fail('The attribute java_encoding is not a string') 
    }
    if $keep_generated != undef and !is_bool($keep_generated) { 
      fail('The attribute keep_generated is not a boolean') 
    }
    if $mapped_file != undef and !is_bool($mapped_file) { 
      fail('The attribute mapped_file is not a boolean') 
    }
    if $modification_test_interval != undef and !is_integer($modification_test_interval) { 
      fail('The attribute modification_test_interval is not an integer') 
    }
    if $recompile_on_fail != undef and !is_bool($recompile_on_fail) { 
      fail('The attribute recompile_on_fail is not a boolean') 
    }
    if $scratch_dir != undef and !is_string($scratch_dir) { 
      fail('The attribute scratch_dir is not a string') 
    }
    if $smap != undef and !is_bool($smap) { 
      fail('The attribute smap is not a boolean') 
    }
    if $source_vm != undef and !is_string($source_vm) { 
      fail('The attribute source_vm is not a string') 
    }
    if $tag_pooling != undef and !is_bool($tag_pooling) { 
      fail('The attribute tag_pooling is not a boolean') 
    }
    if $target_vm != undef and !is_string($target_vm) { 
      fail('The attribute target_vm is not a string') 
    }
    if $trim_spaces != undef and !is_bool($trim_spaces) { 
      fail('The attribute trim_spaces is not a boolean') 
    }
    if $x_powered_by != undef and !is_bool($x_powered_by) { 
      fail('The attribute x_powered_by is not a boolean') 
    }
  

    $raw_options = { 
      'check-interval'               => $check_interval,
      'development'                  => $development,
      'disabled'                     => $disabled,
      'display-source-fragment'      => $display_source_fragment,
      'dump-smap'                    => $dump_smap,
      'error-on-use-bean-invalid-class-attribute' => $error_on_use_bean_invalid_class_attribute,
      'generate-strings-as-char-arrays' => $generate_strings_as_char_arrays,
      'java-encoding'                => $java_encoding,
      'keep-generated'               => $keep_generated,
      'mapped-file'                  => $mapped_file,
      'modification-test-interval'   => $modification_test_interval,
      'recompile-on-fail'            => $recompile_on_fail,
      'scratch-dir'                  => $scratch_dir,
      'smap'                         => $smap,
      'source-vm'                    => $source_vm,
      'tag-pooling'                  => $tag_pooling,
      'target-vm'                    => $target_vm,
      'trim-spaces'                  => $trim_spaces,
      'x-powered-by'                 => $x_powered_by,
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
