# = Define jboss_admin::module
define jboss_admin::module (
  $jar,
  $jar_name,
  $server,
  $dependencies = [],
  $namespace = $name,
) {
  $server_base_path = getparam($server, 'base_path')
  $module_path      = "${server_base_path}/module"
  $namespace_path   = regsubst($namespace, '\.', '/', 'G')
  $dir_path         = "${module_path}/${namespace_path}/main"

  exec { "${name} Module Dir":
    command => "/bin/mkdir -p ${dir_path}",
    creates => $dir_path
  }

  file { "${dir_path}/${jar_name}":
    ensure  => directory,
    source  => $jar,
    require => Exec["${name} Module Dir"]
  }

  file { "${dir_path}/module.xml":
    ensure   => file,
    content  => template('jboss_admin/module.erb'),
    require  => Exec["${name} Module Dir"]
  }
}
