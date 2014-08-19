# == Defines jboss_admin::configuration_static_resources
#
# Static files serving configuration.
#
# === Parameters
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
# [*secret*]
#   Secret for WebDAV locking operations.
#
# [*disabled*]
#   Disables the default Servlet mapping.
#
# [*file_encoding*]
#   Force a file encoding.
#
# [*webdav*]
#   Enable WebDAV functionality.
#
#
define jboss_admin::resource::configuration_static_resources (
  $server,
  $max_depth                      = undef,
  $listings                       = undef,
  $sendfile                       = undef,
  $read_only                      = undef,
  $secret                         = undef,
  $disabled                       = undef,
  $file_encoding                  = undef,
  $webdav                         = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $max_depth != undef and !is_integer($max_depth) { 
      fail('The attribute max_depth is not an integer') 
    }
    if $sendfile != undef and !is_integer($sendfile) { 
      fail('The attribute sendfile is not an integer') 
    }
  

    $raw_options = { 
      'max-depth'                    => $max_depth,
      'listings'                     => $listings,
      'sendfile'                     => $sendfile,
      'read-only'                    => $read_only,
      'secret'                       => $secret,
      'disabled'                     => $disabled,
      'file-encoding'                => $file_encoding,
      'webdav'                       => $webdav,
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
