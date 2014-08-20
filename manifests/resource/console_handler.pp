# == Defines jboss_admin::console_handler
#
# Defines a handler which writes to the console.
#
# === Parameters
#
# [*autoflush*]
#   Automatically flush after each write.
#
# [*encoding*]
#   The character encoding used by this Handler.
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
# [*target*]
#   Defines the target of the console handler. The value can either be SYSTEM_OUT or SYSTEM_ERR.
#
#
define jboss_admin::resource::console_handler (
  $server,
  $autoflush                      = undef,
  $encoding                       = undef,
  $filter                         = undef,
  $formatter                      = undef,
  $level                          = undef,
  $resource_name                  = undef,
  $target                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'autoflush'                    => $autoflush,
      'encoding'                     => $encoding,
      'filter'                       => $filter,
      'formatter'                    => $formatter,
      'level'                        => $level,
      'name'                         => $resource_name,
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
