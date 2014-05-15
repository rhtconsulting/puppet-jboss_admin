# == Defines jboss_admin::file-handler
#
# Defines a handler which writes to a file.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*file*]
#   The file description consisting of the path and optional relative to path.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*name*]
#   The handler's name.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::resource::file-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $append                         = undef,
  $file                           = undef,
  $encoding                       = undef,
  $level                          = undef,
  $name                           = undef,
  $autoflush                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'append'                       => $append,
      'file'                         => $file,
      'encoding'                     => $encoding,
      'level'                        => $level,
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
