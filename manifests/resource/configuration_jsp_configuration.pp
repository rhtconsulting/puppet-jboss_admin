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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $check_interval != undef and !is_integer($check_interval) {
      fail('The attribute check_interval is not an integer')
    }
    if $development != undef {
      validate_bool($development)
    }
    if $disabled != undef {
      validate_bool($disabled)
    }
    if $display_source_fragment != undef {
      validate_bool($display_source_fragment)
    }
    if $dump_smap != undef {
      validate_bool($dump_smap)
    }
    if $error_on_use_bean_invalid_class_attribute != undef {
      validate_bool($error_on_use_bean_invalid_class_attribute)
    }
    if $generate_strings_as_char_arrays != undef {
      validate_bool($generate_strings_as_char_arrays)
    }
    if $keep_generated != undef {
      validate_bool($keep_generated)
    }
    if $mapped_file != undef {
      validate_bool($mapped_file)
    }
    if $modification_test_interval != undef and !is_integer($modification_test_interval) {
      fail('The attribute modification_test_interval is not an integer')
    }
    if $recompile_on_fail != undef {
      validate_bool($recompile_on_fail)
    }
    if $smap != undef {
      validate_bool($smap)
    }
    if $tag_pooling != undef {
      validate_bool($tag_pooling)
    }
    if $trim_spaces != undef {
      validate_bool($trim_spaces)
    }
    if $x_powered_by != undef {
      validate_bool($x_powered_by)
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
