# == Defines jboss_admin::group_search_principal_to_group
#
# A group search where the principal entries contain an attribute referencing the groups that they are a member of.
#
# === Parameters
#
# [*group_attribute*]
#   The attribute on the principal which references the group the principal is a member of.
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
#
define jboss_admin::resource::group_search_principal_to_group (
  $server,
  $group_attribute                = undef,
  $group_dn_attribute             = undef,
  $group_name                     = undef,
  $group_name_attribute           = undef,
  $iterative                      = undef,
  $prefer_original_connection     = undef,
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

    $raw_options = {
      'group-attribute'              => $group_attribute,
      'group-dn-attribute'           => $group_dn_attribute,
      'group-name'                   => $group_name,
      'group-name-attribute'         => $group_name_attribute,
      'iterative'                    => $iterative,
      'prefer-original-connection'   => $prefer_original_connection,
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
