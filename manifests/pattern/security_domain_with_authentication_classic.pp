# == Defines jboss_admin::pattern::security_domain_with_authentication_classic
#
# Configures a security domain using classic authentication.
#
# === Parameters
#
# [*security_domain_name*]
#   The name of the security domain to create.
#
# [*cache_type*]
#   Adds a cache to speed up authentication checks. Allowed values are 'default' to use simple map as the cache and 'infinispan' to use an Infinispan cache.
#   Defaults to the resource name.
#
# [*code*]
#   Class name of the module to be instantiated.
#
# [*flag*]
#   The flag controls how the module participates in the overall procedure. Allowed values are requisite, required, sufficient or optional.
#
# [*module*]
#   Name of JBoss Module where the login module is located.
#
# [*module_options*]
#   List of module options containing a name/value pair.
#
# === Examples
#
#   jboss_admin::pattern::security_domain_with_authentication_classic { 'exampleEncryptedSecurityDomain':
#     server               => example,
#     cache_type           => 'default',
#     code                 => 'org.picketbox.datasource.security.SecureIdentityLoginModule',
#     flag                 => 'required',
#     module_options       => {
#       'username'                     => 'ds_user_name',
#       'password'                     => 'secret',
#       'managedConnectionFactoryName' => "jboss.jca:service=LocalTxCM,name=examplePOOL",
#     },
#     ensure               => present,
#   }
#
define jboss_admin::pattern::security_domain_with_authentication_classic (
  $server,
  $security_domain_name = $name,
  $cache_type           = undef,
  $code                 = undef,
  $flag                 = undef,
  $module               = undef,
  $module_options       = undef,
  $ensure               = present,
) {

  # validation of pattern specific attributes
  if $security_domain_name == undef or empty($security_domain_name) or !is_string($security_domain_name) {
    fail('The attribute security_domain_name must be a defined none empty string')
  }

  # configure the data source and security configuration
  $_security_domain_path                   = "/subsystem=security/security-domain=${security_domain_name}"
  $_security_domain_auth_path              = "${_security_domain_path}/authentication=classic"
  $_security_domain_auth_login_module_path = "${_security_domain_auth_path}/login-module=${code}"
  jboss_admin::resource::security_domain { $_security_domain_path:
    server     => $server,
    cache_type => $cache_type,
    ensure     => $ensure,
  }
  jboss_admin::resource::authentication_classic { $_security_domain_auth_path:
    server        => $server,
    ensure        => $ensure,
  }
  jboss_admin::resource::login_module { $_security_domain_auth_login_module_path:
    server         => $server,
    code           => $code,
    flag           => $flag,
    module         => $module,
    module_options => $module_options,
    ensure         => $ensure,
  }
}
