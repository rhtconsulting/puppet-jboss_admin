# == Defines jboss_admin::size-rotating-file-handler
#
# Defines a handler which writes to a file, rotating the log after a the size of the file grows beyond a certain point and keeping a fixed number of backups.
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
# [*rotate_size*]
#   The size at which to rotate the log file.
#
# [*level*]
#   The log level specifying which message levels will be logged by this. Message levels lower than this value will be discarded.
#
# [*append*]
#   Specify whether to append to the target file.
#
# [*max_backup_index*]
#   The maximum number of backups to keep.
#
# [*name*]
#   The handler's name.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::size-rotating-file-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $file                           = undef,
  $encoding                       = undef,
  $rotate_size                    = undef,
  $level                          = undef,
  $append                         = undef,
  $max_backup_index               = undef,
  $name                           = undef,
  $autoflush                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_backup_index != undef && !is_integer($max_backup_index) { 
      fail('The attribute max_backup_index is not an integer') 
    }
  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'file'                         => $file,
      'encoding'                     => $encoding,
      'rotate-size'                  => $rotate_size,
      'level'                        => $level,
      'append'                       => $append,
      'max-backup-index'             => $max_backup_index,
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
