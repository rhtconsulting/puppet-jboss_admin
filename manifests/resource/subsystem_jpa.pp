# == Defines jboss_admin::subsystem_jpa
#
# The configuration of the JPA subsystem.
#
# === Parameters
#
# [*default_datasource*]
#   The name of the default global datasource.
#
# [*default_extended_persistence_inheritance*]
#   Controls how JPA extended persistence context (XPC) inheritance is performed. 'DEEP' shares the extended persistence context at top bean level.  'SHALLOW' the extended persistece context is only shared with the parent bean (never with sibling beans).
#
#
define jboss_admin::resource::subsystem_jpa (
  $server,
  $default_datasource             = undef,
  $default_extended_persistence_inheritance = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $default_extended_persistence_inheritance != undef and $default_extended_persistence_inheritance != undefined and !($default_extended_persistence_inheritance in ['DEEP','SHALLOW']) {
      fail('The attribute default_extended_persistence_inheritance is not an allowed value: "DEEP","SHALLOW"')
    }

    $raw_options = {
      'default-datasource'           => $default_datasource,
      'default-extended-persistence-inheritance' => $default_extended_persistence_inheritance,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $name:
      address => $cli_path,
      ensure  => $ensure,
      server  => $server,
      options => $options
    }
  }

  if $ensure == absent {
    jboss_resource { $cli_path:
      ensure => $ensure,
      server => $server
    }
  }
}
