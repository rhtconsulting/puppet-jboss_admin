# == Defines jboss_admin::json_formatter
#
# A json formatter for audit log messages.
#
# === Parameters
#
# [*compact*]
#   If true will format the JSON on one line. There may still be values containing new lines, so if having the whole record on one line is important, set escape-new-line or escape-control-characters to true.
#
# [*date_format*]
#   The date format to use as understood by {@link java.text.SimpleDateFormat}. Will be ignored if include-date="false".
#
# [*date_separator*]
#   The separator between the date and the rest of the formatted log message. Will be ignored if include-date="false".
#
# [*escape_control_characters*]
#   If true will escape all control characters (ascii entries with a decimal value < 32) with the ascii code in octal, e.g.'
#    becomes '#012'. If this is true, it will override escape-new-line="false".
#
# [*escape_new_line*]
#   If true will escape all new lines with the ascii code in octal, e.g. "#012".
#
# [*include_date*]
#   Whether or not to include the date in the formatted log record.
#
#
define jboss_admin::resource::json_formatter (
  $server,
  $compact                        = undef,
  $date_format                    = undef,
  $date_separator                 = undef,
  $escape_control_characters      = undef,
  $escape_new_line                = undef,
  $include_date                   = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $compact != undef and $compact != undefined {
      validate_bool($compact)
    }
    if $escape_control_characters != undef and $escape_control_characters != undefined {
      validate_bool($escape_control_characters)
    }
    if $escape_new_line != undef and $escape_new_line != undefined {
      validate_bool($escape_new_line)
    }
    if $include_date != undef and $include_date != undefined {
      validate_bool($include_date)
    }

    $raw_options = {
      'compact'                      => $compact,
      'date-format'                  => $date_format,
      'date-separator'               => $date_separator,
      'escape-control-characters'    => $escape_control_characters,
      'escape-new-line'              => $escape_new_line,
      'include-date'                 => $include_date,
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
