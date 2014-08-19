# == Defines jboss_admin::file_handler
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
define jboss_admin::resource::file_handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
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
