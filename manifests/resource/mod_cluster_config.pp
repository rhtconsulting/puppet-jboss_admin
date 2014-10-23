# == Defines jboss_admin::mod_cluster_config
#
# The common modcluster configuration.
#
# === Parameters
#
# [*advertise*]
#   Use Advertise logic or not.
#
# [*advertise_security_key*]
#   String containing the security key for the Advertise logic.
#
# [*advertise_socket*]
#   Name of Socket binding to use for the Advertise socket.
#
# [*auto_enable_contexts*]
#   Enable contexts even if disabled in mod_cluster_manger (httpd).
#
# [*balancer*]
#   The balancer name.
#
# [*connector*]
#   Name of the web connector used to communicate with the load balancer.
#
# [*excluded_contexts*]
#   List of contexts mod_cluster should ignore, Format String separated with commas.
#
# [*flush_packets*]
#   Enables/disables packet flushing in httpd.
#
# [*flush_wait*]
#   Time to wait before flushing packets in httpd.
#
# [*load_balancing_group*]
#   loadBalancingGroup name.
#
# [*max_attempts*]
#   Max attempts to process an idempotent request.
#
# [*node_timeout*]
#   Timeout (in seconds) for proxy connections to a node.
#
# [*ping*]
#   Time (in seconds) in which to wait for a pong answer to a ping.
#
# [*proxy_list*]
#   List of proxies, Format (hostname:port) separated with comas.
#
# [*proxy_url*]
#   Base URL for MCMP requests.
#
# [*session_draining_strategy*]
#   Session draining strategy used during undeployment of a web application
#
# [*simple_load_provider*]
#   Simple load provider
#
# [*smax*]
#   Soft maximum idle connection count in httpd
#
# [*socket_timeout*]
#   Timeout to wait for httpd to answer a MCMP message.
#
# [*sticky_session*]
#   Use sticky sessions for requests.
#
# [*sticky_session_force*]
#   Don't failover a request with session information.
#
# [*sticky_session_remove*]
#   Remove session information on failover.
#
# [*stop_context_timeout*]
#   Max time to wait for context to process pending requests.
#
# [*ttl*]
#   Time to live (in seconds) for idle connections above smax
#
# [*worker_timeout*]
#   Timeout to wait in httpd for an available worker to process the requests.
#
#
define jboss_admin::resource::mod_cluster_config (
  $server,
  $advertise                      = undef,
  $advertise_security_key         = undef,
  $advertise_socket               = undef,
  $auto_enable_contexts           = undef,
  $balancer                       = undef,
  $connector                      = undef,
  $excluded_contexts              = undef,
  $flush_packets                  = undef,
  $flush_wait                     = undef,
  $load_balancing_group           = undef,
  $max_attempts                   = undef,
  $node_timeout                   = undef,
  $ping                           = undef,
  $proxy_list                     = undef,
  $proxy_url                      = undef,
  $session_draining_strategy      = undef,
  $simple_load_provider           = undef,
  $smax                           = undef,
  $socket_timeout                 = undef,
  $sticky_session                 = undef,
  $sticky_session_force           = undef,
  $sticky_session_remove          = undef,
  $stop_context_timeout           = undef,
  $ttl                            = undef,
  $worker_timeout                 = undef,
  $ensure                         = present,
  $cli_path                       = $name
) {
  if $ensure == present {

    if $advertise != undef { 
      validate_bool($advertise)
    }
    if $advertise_security_key != undef and !is_string($advertise_security_key) { 
      fail('The attribute advertise_security_key is not a string') 
    }
    if $advertise_socket != undef and !is_string($advertise_socket) { 
      fail('The attribute advertise_socket is not a string') 
    }
    if $auto_enable_contexts != undef { 
      validate_bool($auto_enable_contexts)
    }
    if $balancer != undef and !is_string($balancer) { 
      fail('The attribute balancer is not a string') 
    }
    if $connector != undef and !is_string($connector) { 
      fail('The attribute connector is not a string') 
    }
    if $excluded_contexts != undef and !is_string($excluded_contexts) { 
      fail('The attribute excluded_contexts is not a string') 
    }
    if $flush_packets != undef { 
      validate_bool($flush_packets)
    }
    if $flush_wait != undef and !is_integer($flush_wait) { 
      fail('The attribute flush_wait is not an integer') 
    }
    if $load_balancing_group != undef and !is_string($load_balancing_group) { 
      fail('The attribute load_balancing_group is not a string') 
    }
    if $max_attempts != undef and !is_integer($max_attempts) { 
      fail('The attribute max_attempts is not an integer') 
    }
    if $node_timeout != undef and !is_integer($node_timeout) { 
      fail('The attribute node_timeout is not an integer') 
    }
    if $ping != undef and !is_integer($ping) { 
      fail('The attribute ping is not an integer') 
    }
    if $proxy_list != undef and !is_string($proxy_list) { 
      fail('The attribute proxy_list is not a string') 
    }
    if $proxy_url != undef and !is_string($proxy_url) { 
      fail('The attribute proxy_url is not a string') 
    }
    if $session_draining_strategy != undef and !is_string($session_draining_strategy) { 
      fail('The attribute session_draining_strategy is not a string') 
    }
    if $session_draining_strategy != undef and !($session_draining_strategy in ['DEFAULT','ALWAYS','NEVER']) {
      fail("The attribute session_draining_strategy is not an allowed value: 'DEFAULT','ALWAYS','NEVER'")
    }
    if $simple_load_provider != undef and !is_integer($simple_load_provider) { 
      fail('The attribute simple_load_provider is not an integer') 
    }
    if $smax != undef and !is_integer($smax) { 
      fail('The attribute smax is not an integer') 
    }
    if $socket_timeout != undef and !is_integer($socket_timeout) { 
      fail('The attribute socket_timeout is not an integer') 
    }
    if $sticky_session != undef { 
      validate_bool($sticky_session)
    }
    if $sticky_session_force != undef { 
      validate_bool($sticky_session_force)
    }
    if $sticky_session_remove != undef { 
      validate_bool($sticky_session_remove)
    }
    if $stop_context_timeout != undef and !is_integer($stop_context_timeout) { 
      fail('The attribute stop_context_timeout is not an integer') 
    }
    if $ttl != undef and !is_integer($ttl) { 
      fail('The attribute ttl is not an integer') 
    }
    if $worker_timeout != undef and !is_integer($worker_timeout) { 
      fail('The attribute worker_timeout is not an integer') 
    }
  

    $raw_options = { 
      'advertise'                    => $advertise,
      'advertise-security-key'       => $advertise_security_key,
      'advertise-socket'             => $advertise_socket,
      'auto-enable-contexts'         => $auto_enable_contexts,
      'balancer'                     => $balancer,
      'connector'                    => $connector,
      'excluded-contexts'            => $excluded_contexts,
      'flush-packets'                => $flush_packets,
      'flush-wait'                   => $flush_wait,
      'load-balancing-group'         => $load_balancing_group,
      'max-attempts'                 => $max_attempts,
      'node-timeout'                 => $node_timeout,
      'ping'                         => $ping,
      'proxy-list'                   => $proxy_list,
      'proxy-url'                    => $proxy_url,
      'session-draining-strategy'    => $session_draining_strategy,
      'simple-load-provider'         => $simple_load_provider,
      'smax'                         => $smax,
      'socket-timeout'               => $socket_timeout,
      'sticky-session'               => $sticky_session,
      'sticky-session-force'         => $sticky_session_force,
      'sticky-session-remove'        => $sticky_session_remove,
      'stop-context-timeout'         => $stop_context_timeout,
      'ttl'                          => $ttl,
      'worker-timeout'               => $worker_timeout,
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
