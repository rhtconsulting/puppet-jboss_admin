# == Defines jboss_admin::console-handler
#
# Defines a handler which writes to the console.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*formatter*]
#   Defines a formatter.
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
# [*target*]
#   Defines the target of the console handler. The value can either be SYSTEM_OUT or SYSTEM_ERR.
#
#
define jboss_admin::console-handler (
  $server,
  $filter                         = undef,
  $formatter                      = undef,
  $encoding                       = undef,
  $level                          = undef,
  $name                           = undef,
  $autoflush                      = undef,
  $target                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'encoding'                     => $encoding,
      'level'                        => $level,
      'name'                         => $name,
      'autoflush'                    => $autoflush,
      'target'                       => $target,
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
