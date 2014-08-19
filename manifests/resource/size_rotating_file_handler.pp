# == Defines jboss_admin::size_rotating_file_handler
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
# [*rotate_size*]
#   The size at which to rotate the log file.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*max_backup_index*]
#   The maximum number of backups to keep.
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
define jboss_admin::resource::size_rotating_file_handler (
  $server,
  $filter                         = undef,
  $file                           = undef,
  $rotate_size                    = undef,
  $encoding                       = undef,
  $max_backup_index               = undef,
  $autoflush                      = undef,
  $formatter                      = undef,
  $append                         = undef,
  $level                          = undef,
  $resource_name                  = undef,
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
      'rotate-size'                  => $rotate_size,
      'encoding'                     => $encoding,
      'max-backup-index'             => $max_backup_index,
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
