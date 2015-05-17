jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_admin::pattern::security_domain_with_authentication_classic { 'servlet-security-pattern-quickstart':
  ensure         => present,
  server         => example,
  cache_type     => 'default',
  code           => 'Database',
  flag           => 'required',
  module_options => {
    dsJndiName      => 'java:jboss/datasources/ServletSecurityDS',
    principalsQuery => 'SELECT PASSWORD FROM USERS WHERE USERNAME = ?',
    rolesQuery      => 'SELECT R.NAME, \\\'Roles\\\' FROM USERS_ROLES UR INNER JOIN ROLES R ON R.ID = UR.ROLE_ID INNER JOIN USERS U ON U.ID = UR.USER_ID WHERE U.USERNAME = ?'
  },
}
