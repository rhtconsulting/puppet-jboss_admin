# == Defines jboss_admin::access_authorization
#
# The access control definitions defining the access management restrictions.
#
# === Parameters
#
# [*all_role_names*]
#   The official names of all roles supported by the current management access control provider. This includes any standard roles as well as any user-defined roles.
#
# [*permission_combination_policy*]
#   The policy for combining access control permissions when the authorization policy grants the user more than one type of permission for a given action. In the standard role based authorization policy, this would occur when a user maps to multiple roles. The 'permissive' policy means if any of the permissions allow the action, the action is allowed. The 'rejecting' policy means the existence of multiple permissions should result in an error.
#
# [*provider*]
#   The provider to use for management access control decisions.
#
# [*standard_role_names*]
#   The official names of the standard roles supported by the current management access control provider.
#
#
define jboss_admin::resource::access_authorization (
  $server,
  $all_role_names                 = undef,
  $permission_combination_policy  = undef,
  $provider                       = undef,
  $standard_role_names            = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $all_role_names != undef and !is_array($all_role_names) { 
      fail('The attribute all_role_names is not an array') 
    }
    if $permission_combination_policy != undef and !is_string($permission_combination_policy) { 
      fail('The attribute permission_combination_policy is not a string') 
    }
    if $permission_combination_policy != undef and !($permission_combination_policy in ['permissive','rejecting']) {
      fail("The attribute permission_combination_policy is not an allowed value: 'permissive','rejecting'")
    }
    if $provider != undef and !is_string($provider) { 
      fail('The attribute provider is not a string') 
    }
    if $provider != undef and !($provider in ['simple','rbac']) {
      fail("The attribute provider is not an allowed value: 'simple','rbac'")
    }
    if $standard_role_names != undef and !is_array($standard_role_names) { 
      fail('The attribute standard_role_names is not an array') 
    }
  

    $raw_options = { 
      'all-role-names'               => $all_role_names,
      'permission-combination-policy' => $permission_combination_policy,
      'provider'                     => $provider,
      'standard-role-names'          => $standard_role_names,
    }
    $options = delete_undef_values($raw_options)

    jboss_resource { $cli_path:
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
