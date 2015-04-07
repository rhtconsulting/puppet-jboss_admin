# == Defines jboss_admin::periodic_rotating_file_handler
#
# Defines a handler which writes to a file, rotating the log after a time period derived from the given suffix string, which should be in a format understood by java.text.SimpleDateFormat.
#
# === Parameters
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*autoflush*]
#   Automatically flush after each write.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*file*]
#   The file description consisting of the path and optional relative to path.
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*resource_name*]
#   The handler's name.
#
# [*suffix*]
#   Set the suffix string.  The string is in a format which can be understood by java.text.SimpleDateFormat. The period of the rotation is automatically calculated based on the suffix.
#
#
define jboss_admin::resource::periodic_rotating_file_handler (
  $server,
  $append                         = undef,
  $autoflush                      = undef,
  $encoding                       = undef,
  $file                           = undef,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $suffix                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = {
      'append'                       => $append,
      'autoflush'                    => $autoflush,
      'encoding'                     => $encoding,
      'file'                         => $file,
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'name'                         => $resource_name,
      'suffix'                       => $suffix,
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
