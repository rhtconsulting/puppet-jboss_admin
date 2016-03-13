# == Defines jboss_admin::log_file
#
# Log files that are available to be read.
#
# === Parameters
#
# [*file_size*]
#   The size of the log file in bytes.
#
# [*last_modified_time*]
#   The date, in milliseconds, the file was last modified.
#
# [*last_modified_timestamp*]
#   The date, in ISO 8601 format, the file was last modified.
#
# [*stream*]
#   Provides the server log as a response attachment. The response result value is the unique id of the attachment.
#
#
define jboss_admin::resource::log_file (
  $server,
  $file_size                      = undef,
  $last_modified_time             = undef,
  $last_modified_timestamp        = undef,
  $stream                         = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $file_size != undef and $file_size != undefined and !is_integer($file_size) {
      fail('The attribute file_size is not an integer')
    }
    if $last_modified_time != undef and $last_modified_time != undefined and !is_integer($last_modified_time) {
      fail('The attribute last_modified_time is not an integer')
    }
    if $stream != undef and $stream != undefined and !is_integer($stream) {
      fail('The attribute stream is not an integer')
    }

    $raw_options = {
      'file-size'                    => $file_size,
      'last-modified-time'           => $last_modified_time,
      'last-modified-timestamp'      => $last_modified_timestamp,
      'stream'                       => $stream,
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
