# == Defines jboss_admin::file_handler
#
# Defines a handler which writes to a file.
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
#
define jboss_admin::resource::file_handler (
  $server,
  $append                         = undef,
  $autoflush                      = undef,
  $encoding                       = undef,
  $file                           = undef,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
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
