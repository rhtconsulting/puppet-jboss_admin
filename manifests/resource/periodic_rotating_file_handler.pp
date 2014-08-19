# == Defines jboss_admin::periodic_rotating_file_handler
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
# [*suffix*]
#   Set the suffix string.  The string is in a format which can be understood by java.text.SimpleDateFormat. The period of the rotation is automatically calculated based on the suffix.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*autoflush*]
#   Automatically flush after each write.
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
# [*resource_name*]
#   The handler's name.
#
#
define jboss_admin::resource::periodic_rotating_file_handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
  $suffix                         = undef,
  $encoding                       = undef,
  $autoflush                      = undef,
  $formatter                      = undef,
  $append                         = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'file'                         => $file,
      'suffix'                       => $suffix,
      'encoding'                     => $encoding,
      'autoflush'                    => $autoflush,
      'formatter'                    => $formatter,
      'append'                       => $append,
      'level'                        => $level,
      'name'                         => $resource_name,
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
