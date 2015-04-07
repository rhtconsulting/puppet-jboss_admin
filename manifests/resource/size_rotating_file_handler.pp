# == Defines jboss_admin::size_rotating_file_handler
#
# Defines a handler which writes to a file, rotating the log after a the size of the file grows beyond a certain point and keeping a fixed number of backups.
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
# [*max_backup_index*]
#   The maximum number of backups to keep.
#
# [*resource_name*]
#   The handler's name.
#
# [*rotate_size*]
#   The size at which to rotate the log file.
#
#
define jboss_admin::resource::size_rotating_file_handler (
  $server,
  $append                         = undef,
  $autoflush                      = undef,
  $encoding                       = undef,
  $file                           = undef,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $max_backup_index               = undef,
  $resource_name                  = undef,
  $rotate_size                    = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_backup_index != undef and !is_integer($max_backup_index) {
      fail('The attribute max_backup_index is not an integer')
    }
  

    $raw_options = {
      'append'                       => $append,
      'autoflush'                    => $autoflush,
      'encoding'                     => $encoding,
      'file'                         => $file,
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'max-backup-index'             => $max_backup_index,
      'name'                         => $resource_name,
      'rotate-size'                  => $rotate_size,
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
