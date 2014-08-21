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
 becomes '#012'. If this is true, it will override escape-new-line="false".
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
  $path                           = $name
) {
  if $ensure == present {

    if $compact != undef and !is_bool($compact) { 
      fail('The attribute compact is not a boolean') 
    }
    if $date_format != undef and !is_string($date_format) { 
      fail('The attribute date_format is not a string') 
    }
    if $date_separator != undef and !is_string($date_separator) { 
      fail('The attribute date_separator is not a string') 
    }
    if $escape_control_characters != undef and !is_bool($escape_control_characters) { 
      fail('The attribute escape_control_characters is not a boolean') 
    }
    if $escape_new_line != undef and !is_bool($escape_new_line) { 
      fail('The attribute escape_new_line is not a boolean') 
    }
    if $include_date != undef and !is_bool($include_date) { 
      fail('The attribute include_date is not a boolean') 
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
