# == Defines jboss_admin::configuration_static-resources
#
# Static files serving configuration.
#
# === Parameters
#
# [*file_encoding*]
#   Force a file encoding.
#
# [*webdav*]
#   Enable WebDAV functionality.
#
# [*secret*]
#   Secret for WebDAV locking operations.
#
# [*max_depth*]
#   Maximum recursion for PROPFIND.
#
# [*listings*]
#   Enable folder listings.
#
# [*sendfile*]
#   Enable sendfile if possible, for files bigger than the specified byte size.
#
# [*read_only*]
#   Allow write HTTP methods (PUT, DELETE).
#
# [*disabled*]
#   Disables the default Servlet mapping.
#
#
define jboss_admin::configuration_static-resources (
  $server,
  $file_encoding                  = undef,
  $webdav                         = undef,
  $secret                         = undef,
  $max_depth                      = undef,
  $listings                       = undef,
  $sendfile                       = undef,
  $read_only                      = undef,
  $disabled                       = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_depth != undef && !is_integer($max_depth) { 
      fail('The attribute max_depth is not an integer') 
    }
    if $sendfile != undef && !is_integer($sendfile) { 
      fail('The attribute sendfile is not an integer') 
    }
  

    $raw_options = { 
      'file-encoding'                => $file_encoding,
      'webdav'                       => $webdav,
      'secret'                       => $secret,
      'max-depth'                    => $max_depth,
      'listings'                     => $listings,
      'sendfile'                     => $sendfile,
      'read-only'                    => $read_only,
      'disabled'                     => $disabled,
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
