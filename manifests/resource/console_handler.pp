# == Defines jboss_admin::console_handler
#
# Defines a handler which writes to the console.
#
# === Parameters
#
# [*filter*]
#   Defines a simple filter type.
#
# [*encoding*]
#   The character encoding used by this Handler.
#
# [*autoflush*]
#   Automatically flush after each write.
#
# [*target*]
#   Defines the target of the console handler. The value can either be SYSTEM_OUT or SYSTEM_ERR.
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
define jboss_admin::resource::console_handler (
  $server,
  $filter                         = undef,
  $encoding                       = undef,
  $autoflush                      = undef,
  $target                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'filter'                       => $filter,
      'encoding'                     => $encoding,
      'autoflush'                    => $autoflush,
      'target'                       => $target,
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
