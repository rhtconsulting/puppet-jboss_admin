# == Defines jboss_admin::group_search_group_to_principal
#
# A group search where the group entry contains an attribute referencing it's members.
#
# === Parameters
#
# [*base_dn*]
#   The starting point of the search for the group.
#
# [*group_dn_attribute*]
#   Which attribute on a group entry is it's distingushed name.
#
# [*group_name*]
#   An enumeration to identify if groups should be referenced using a simple name or their distinguished name.
#
# [*group_name_attribute*]
#   Which attribute on a group entry is it's simple name.
#
# [*iterative*]
#   Should further searches be performed to identify groups that the groups identified are a member of?
#
# [*prefer_original_connection*]
#   After following a referral should subsequent searches prefer the original connection or use the connection of the last referral.
#
# [*principal_attribute*]
#   The attribute on the group entry that references the principal.
#
# [*recursive*]
#   Should levels below the starting point be recursively searched?
#
# [*search_by*]
#   Should searches be performed using simple names or distinguished names?
#
#
define jboss_admin::resource::group_search_group_to_principal (
  $server,
  $base_dn                        = undef,
  $group_dn_attribute             = undef,
  $group_name                     = undef,
  $group_name_attribute           = undef,
  $iterative                      = undef,
  $prefer_original_connection     = undef,
  $principal_attribute            = undef,
  $recursive                      = undef,
  $search_by                      = undef,
  $ensure                         = present,
  $cli_path                       = $name,
) {
  if $ensure == present {
    if $group_name != undef and $group_name != undefined and !($group_name in ['DISTINGUISHED_NAME','SIMPLE']) {
      fail('The attribute group_name is not an allowed value: "DISTINGUISHED_NAME","SIMPLE"')
    }
    if $iterative != undef and $iterative != undefined {
      validate_bool($iterative)
    }
    if $prefer_original_connection != undef and $prefer_original_connection != undefined {
      validate_bool($prefer_original_connection)
    }
    if $recursive != undef and $recursive != undefined {
      validate_bool($recursive)
    }
    if $search_by != undef and $search_by != undefined and !($search_by in ['DISTINGUISHED_NAME','SIMPLE']) {
      fail('The attribute search_by is not an allowed value: "DISTINGUISHED_NAME","SIMPLE"')
    }

    $raw_options = {
      'base-dn'                      => $base_dn,
      'group-dn-attribute'           => $group_dn_attribute,
      'group-name'                   => $group_name,
      'group-name-attribute'         => $group_name_attribute,
      'iterative'                    => $iterative,
      'prefer-original-connection'   => $prefer_original_connection,
      'principal-attribute'          => $principal_attribute,
      'recursive'                    => $recursive,
      'search-by'                    => $search_by,
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
