jboss_admin::server{ 'example':
  base_path => '/opt/jboss'
}

Jboss_admin::Resource::Periodic_rotating_file_handler{
  suffix => '.yyyy.MM.dd',
  server => example
}

Jboss_admin::Resource::Async_handler{
  queue_length    => 1024,
  overflow_action => BLOCK,
  server          => example
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_TRACE':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_TRACE',
  file => {"path"=>"quickstart.trace.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_DEBUG':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_DEBUG',
  file => {"path"=>"quickstart.debug.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_INFO':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_INFO',
  file => {"path"=>"quickstart.info.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_WARN':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_WARN',
  file => {"path"=>"quickstart.warn.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_ERROR':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_ERROR',
  file => {"path"=>"quickstart.error.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::periodic_rotating_file_handler{'FILE_QS_FATAL':
  path => '/subsystem=logging/periodic-rotating-file-handler=FILE_QS_FATAL',
  file => {"path"=>"quickstart.fatal.log", "relative-to"=>"jboss.server.log.dir"}
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=TRACE_QS_ASYNC':
  level       => TRACE,
  subhandlers => ['FILE_QS_TRACE'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_TRACE']
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=DEBUG_QS_ASYNC':
  level       => DEBUG,
  subhandlers => ['FILE_QS_DEBUG'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_DEBUG']
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=INFO_QS_ASYNC':
  level       => INFO,
  subhandlers => ['FILE_QS_INFO'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_INFO']
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=WARN_QS_ASYNC':
  level       => WARN,
  subhandlers => ['FILE_QS_WARN'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_WARN']
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=ERROR_QS_ASYNC':
  level       => ERROR,
  subhandlers => ['FILE_QS_ERROR'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_ERROR']
}

jboss_admin::resource::async_handler{'/subsystem=logging/async-handler=FATAL_QS_ASYNC':
  level       => FATAL,
  subhandlers => ['FILE_QS_FATAL'],
  require     => Jboss_admin::Resource::Periodic_rotating_file_handler['FILE_QS_FATAL']
}

Jboss_admin::Resource::Async_handler<| server == example |> ->
jboss_admin::resource::logger{'/subsystem=logging/logger=org.jboss.as.quickstarts.logging':
  level    => TRACE,
  handlers => ['TRACE_QS_ASYNC','DEBUG_QS_ASYNC','INFO_QS_ASYNC','WARN_QS_ASYNC','ERROR_QS_ASYNC','FATAL_QS_ASYNC'],
  server   => example
}
