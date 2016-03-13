# == Defines jboss_admin::periodic_size_rotating_file_handler
#
# Defines a handler which writes to a file, rotating the log after a time period derived from the given suffix string or after the size of the file grows beyond a certain point and keeping a fixed number of backups. The suffix should be in a format understood by the java.text.SimpleDateFormat. Any backups rotated by the suffix will not be purged during a size rotation.
#
# === Parameters
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*autoflush*]
#   Automatically flush after each write.
#
# [*enabled*]
#   If set to true the handler is enabled and functioning as normal, if set to false the handler is ignored when processing log messages.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*file*]
#   The file description consisting of the path and optional relative to path.
#
# [*filter_spec*]
#   A filter expression value to define a filter. Example for a filter that does not match a pattern: not(match("JBAS.*"))
#
# [*formatter*]
#   Defines a pattern for the formatter.
#
# [*level*]
#   The log level specifying which message levels will be logged by this logger. Message levels lower than this value will be discarded.
#
# [*max_backup_index*]
#   The maximum number of backups to keep.
#
# [*resource_name*]
#   The name of the handler.
#
# [*named_formatter*]
#   The name of the defined formatter to be used on the handler.
#
# [*rotate_on_boot*]
#   Indicates the file should be rotated each time the file attribute is changed. This always happens when at initialization time.
#
# [*rotate_size*]
#   The size at which to rotate the log file.
#
# [*suffix*]
#   Set the suffix string.  The string is in a format which can be understood by java.text.SimpleDateFormat. The period of the rotation is automatically calculated based on the suffix.
#
#
define jboss_admin::resource::periodic_size_rotating_file_handler (
  $server,
  $append                         = undef,
  $autoflush                      = undef,
  $enabled                        = undef,
  $encoding                       = undef,
  $file                           = undef,
  $filter_spec                    = undef,
  $formatter                      = undef,
  $level                          = undef,
  $max_backup_index               = undef,
  $resource_name                  = undef,
  $named_formatter                = undef,
  $rotate_on_boot                 = undef,
  $rotate_size                    = undef,
  $suffix                         = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $append != undef and $append != undefined {
      validate_bool($append)
    }
    if $autoflush != undef and $autoflush != undefined {
      validate_bool($autoflush)
    }
    if $enabled != undef and $enabled != undefined {
      validate_bool($enabled)
    }
    if $level != undef and $level != undefined and !($level in ['ALL','FINEST','FINER','TRACE','DEBUG','FINE','CONFIG','INFO','WARN','WARNING','ERROR','SEVERE','FATAL','OFF']) {
      fail('The attribute level is not an allowed value: "ALL","FINEST","FINER","TRACE","DEBUG","FINE","CONFIG","INFO","WARN","WARNING","ERROR","SEVERE","FATAL","OFF"')
    }
    if $max_backup_index != undef and $max_backup_index != undefined and !is_integer($max_backup_index) {
      fail('The attribute max_backup_index is not an integer')
    }
    if $rotate_on_boot != undef and $rotate_on_boot != undefined {
      validate_bool($rotate_on_boot)
    }

    $raw_options = {
      'append'                       => $append,
      'autoflush'                    => $autoflush,
      'enabled'                      => $enabled,
      'encoding'                     => $encoding,
      'file'                         => $file,
      'filter-spec'                  => $filter_spec,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'max-backup-index'             => $max_backup_index,
      'name'                         => $resource_name,
      'named-formatter'              => $named_formatter,
      'rotate-on-boot'               => $rotate_on_boot,
      'rotate-size'                  => $rotate_size,
      'suffix'                       => $suffix,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
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
