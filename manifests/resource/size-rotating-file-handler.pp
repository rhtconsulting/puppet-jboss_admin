# == Defines jboss_admin::size-rotating-file-handler
#
# Defines a handler which writes to a file, rotating the log after a the size of the file grows beyond a certain point and keeping a fixed number of backups.
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
# [*rotate_size*]
#   The size at which to rotate the log file.
#
# [*_name*]
#   The handler's name.
#
# [*max_backup_index*]
#   The maximum number of backups to keep.
#
# [*autoflush*]
#   Automatically flush after each write.
#
#
define jboss_admin::resource::size-rotating-file-handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
  $encoding                       = undef,
  $formatter                      = undef,
  $append                         = undef,
  $level                          = undef,
  $rotate_size                    = undef,
  $_name                          = undef,
  $max_backup_index               = undef,
  $autoflush                      = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_backup_index != undef and !is_integer($max_backup_index) { 
      fail('The attribute max_backup_index is not an integer') 
    }
  

    $raw_options = { 
      'filter'                       => $filter,
      'file'                         => $file,
      'encoding'                     => $encoding,
      'formatter'                    => $formatter,
      'append'                       => $append,
      'level'                        => $level,
      'rotate-size'                  => $rotate_size,
      'name'                         => $_name,
      'max-backup-index'             => $max_backup_index,
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
