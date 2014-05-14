# == Defines jboss_admin::periodic-rotating-file-handler
#
# Defines a handler which writes to a file, rotating the log after a time period derived from the given suffix string, which should be in a format understood by java.text.SimpleDateFormat.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
#
# [*file*]
#   The file description consisting of the path and optional relative to path.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*suffix*]
#   Set the suffix string.  The string is in a format which can be understood by java.text.SimpleDateFormat. The period of the rotation is automatically calculated based on the suffix.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*name*]
#   The handler's name.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::periodic-rotating-file-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $file                           = undef,
  $encoding                       = undef,
  $suffix                         = undef,
  $level                          = undef,
  $append                         = undef,
  $name                           = undef,
  $autoflush                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'file'                         => $file,
      'encoding'                     => $encoding,
      'suffix'                       => $suffix,
      'level'                        => $level,
      'append'                       => $append,
      'name'                         => $name,
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
