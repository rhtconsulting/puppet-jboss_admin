# = Define jboss_admin::module
#
# Creates the file structure for a module, including the module.xml, 
# and manages the resource jar.
#
# = Example
#
#  jboss_admin::module{ 'com.mysql':
#    ensure        => present,
#    server        => standalone,
#    resource_path => '/tmp/mysql-connector-java-5.1.29.jar',
#    dependencies  => ['javax.api', 'javax.transaction.api'],
#  }
#
define jboss_admin::module (
  $resource_path,
  $server,
  $dependencies = [],
  $namespace    = $name,
  $ensure       = present
) {
  $server_ref       = "Jboss_admin::Server[${server}]"
  $server_base_path = getparam($server_ref, 'base_path')
  $server_user      = getparam($server_ref, 'user')
  $server_group     = getparam($server_ref, 'group')
  $module_path      = "${server_base_path}/modules"
  $namespace_path   = regsubst($namespace, '\.', '/', 'G')
  $dir_path         = "${module_path}/${namespace_path}/main"
  $resource_name    = inline_template('<%= File.basename(@resource_path) %>')
  

  File {
    owner => $server_user,
    group => $server_group
  }

  $parent_dirs = child_directory_list($module_path, "${namespace_path}/main")
  @file { $parent_dirs:
    ensure => directory,
    tag    => ['moduledir', $namespace]
  }
  File <| tag == moduledir and tag == $namespace |>

  file { "${dir_path}/${resource_name}":
    ensure  => file,
    source  => $resource_path
  }

  file { "${dir_path}/module.xml":
    ensure   => file,
    content  => template('jboss_admin/module.erb')
  }
}
