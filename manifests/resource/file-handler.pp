# == Defines jboss_admin::file-handler
#
# Defines a handler which writes to a file.
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
# [*_name*]
#   The handler's name.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::resource::file-handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
  $encoding                       = undef,
  $formatter                      = undef,
  $append                         = undef,
  $level                          = undef,
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
