# == Defines jboss_admin::subsystem_security
#
# The configuration of the security subsystem.
#
# === Parameters
#
# [*deep_copy_subject_mode*]
#   Sets the copy mode of subjects done by the security managers to be deep copies that makes copies of the subject principals and credentials if they are cloneable. It should be set to true if subject include mutable content that can be corrupted when multiple threads have the same identity and cache flushes/logout clearing the subject in one thread results in subject references affecting other threads.
#
#
define jboss_admin::resource::subsystem_security (
  $server,
  $deep_copy_subject_mode         = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $deep_copy_subject_mode != undef and $deep_copy_subject_mode != undefined {
      validate_bool($deep_copy_subject_mode)
    }

    $raw_options = {
      'deep-copy-subject-mode'       => $deep_copy_subject_mode,
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
