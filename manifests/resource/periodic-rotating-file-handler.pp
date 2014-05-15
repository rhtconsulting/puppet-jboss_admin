# == Defines jboss_admin::periodic-rotating-file-handler
#
# Defines a handler which writes to a file, rotating the log after a time period derived from the given suffix string, which should be in a format understood by java.text.SimpleDateFormat.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*file*]
#   The file description consisting of the path and optional relative to path.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*formatter*]
#   Defines a formatter.
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*suffix*]
#   Set the suffix string.  The string is in a format which can be understood by java.text.SimpleDateFormat. The period of the rotation is automatically calculated based on the suffix.
#
# [*_name*]
#   The handler's name.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::resource::periodic-rotating-file-handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
  $encoding                       = undef,
  $formatter                      = undef,
  $append                         = undef,
  $level                          = undef,
  $suffix                         = undef,
  $_name                          = undef,
  $autoflush                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'file'                         => $file,
      'encoding'                     => $encoding,
      'formatter'                    => $formatter,
      'append'                       => $append,
      'level'                        => $level,
      'suffix'                       => $suffix,
      'name'                         => $_name,
      'autoflush'                    => $autoflush,
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
