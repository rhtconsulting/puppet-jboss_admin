jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

jboss_admin::security-domain { '/subsystem=security/security-domain=servlet-security-quickstart':
  cache_type => 'default',
  server     => Jboss_admin::Server[example]
}

jboss_admin::authentication_classic { '/subsystem=security/security-domain=servlet-security-quickstart/authentication=classic':
  login_modules => [{
    "code"=>"Database", 
    "flag"=>"required", 
    "module-options"=>{
      "dsJndiName"=>"java:jboss/datasources/ServletSecurityDS",
      "principalsQuery"=>"SELECT PASSWORD FROM USERS WHERE USERNAME = ?", 
      "rolesQuery"=>"SELECT R.NAME, \'Roles\' FROM USERS_ROLES UR INNER JOIN ROLES R ON R.ID = UR.ROLE_ID INNER JOIN USERS U ON U.ID = UR.USER_ID WHERE U.USERNAME = ?"
    }
  }],
  server        => Jboss_admin::Server[example]
}


