# == Defines jboss_admin::path
#
# A named filesystem path.
#
# === Parameters
#
# [*relative_to*]
#   The name of another previously named path, or of one of the standard paths provided by the system. If 'relative-to' is provided, the value of the 'path' attribute is treated as relative to the path specified by this attribute. The standard paths provided by the system include:<ul><li>jboss.home - the root directory of the JBoss AS distribution</li><li>user.home - user's home directory</li><li>user.dir - user's current working directory</li><li>java.home - java installation directory</li><li>jboss.server.base.dir - root directory for an individual server instance</li><li>jboss.server.data.dir - directory the server will use for persistent data file storage</li><li>jboss.server.log.dir - directory the server will use for log file storage</li><li>jboss.server.tmp.dir - directory the server will use for temporary file storage</li><li>jboss.domain.servers.dir - directory under which a host controller will create the working area for individual server instances</li></ul>
#
# [*resource_name*]
#   The name of the path. Cannot be one of the standard fixed paths provided by the system: <ul><li>jboss.home - the root directory of the JBoss AS distribution</li><li>user.home - user's home directory</li><li>user.dir - user's current working directory</li><li>java.home - java installation directory</li><li>jboss.server.base.dir - root directory for an individual server instance</li></ul> Note that the system provides other standard paths that can be overridden by declaring them in the configuration file. See the 'relative-to' attribute documentation for a complete list of standard paths.
#
# [*path*]
#   The actual filesystem path. Treated as an absolute path, unless the 'relative-to' attribute is specified, in which case the value is treated as relative to that path. <p>If treated as an absolute path, the actual runtime pathname specified by the value of this attribute will be determined as follows: </p>If this value is already absolute, then the value is directly used.  Otherwise the runtime pathname is resolved in a system-dependent way.  On UNIX systems, a relative pathname is made absolute by resolving it against the current user directory. On Microsoft Windows systems, a relative pathname is made absolute by resolving it against the current directory of the drive named by the pathname, if any; if not, it is resolved against the current user directory.
#
#
define jboss_admin::resource::path (
  $server,
  $relative_to                    = undef,
  $resource_name                  = undef,
  $path                           = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $resource_name == undef { fail('The attribute resource_name is undefined but required') }
    if $path == undef { fail('The attribute path is undefined but required') }
  

    $raw_options = { 
      'relative-to'                  => $relative_to,
      'name'                         => $resource_name,
      'path'                         => $path,
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
