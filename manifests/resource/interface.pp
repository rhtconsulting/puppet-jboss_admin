# == Defines jboss_admin::interface
#
# Interface definition
#
# === Parameters
#
# [*any*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be that the IP address meets at least one of a nested set of criteria, but not necessarily all of the nested criteria. The value of the attribute is a set of criteria. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*any_address*]
#   Attribute indicating that sockets using this interface should be bound to a wildcard address. The IPv6 wildcard address (::) will be used unless the java.net.preferIpV4Stack system property is set to true, in which case the IPv4 wildcard address (0.0.0.0) will be used. If a socket is bound to an IPv6 anylocal address on a dual-stack machine, it can accept both IPv6 and IPv4 traffic; if it is bound to an IPv4 (IPv4-mapped) anylocal address, it can only accept IPv4 traffic.
#
# [*any_ipv4_address*]
#   Attribute indicating that sockets using this interface should be bound to the IPv4 wildcard address (0.0.0.0).
#
# [*any_ipv6_address*]
#   Attribute indicating that sockets using this interface should be bound to the IPv6 wildcard address (::).
#
# [*inet_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not the address matches the given value. Value is either a IP address in IPv6 or IPv4 dotted decimal notation, or a hostname that can be resolved to an IP address. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*link_local_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not the address is link-local. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*loopback*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not it is a loopback address.  An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*loopback_address*]
#   Attribute indicating that the IP address for this interface should be the given value, if a loopback interface exists on the machine. A 'loopback address' may not actually be configured on the machine's loopback interface. Differs from inet-address in that the given value will be used even if no NIC can be found that has the IP specified address associated with it. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*multicast*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not its network interface supports multicast.  An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*resource_name*]
#   The name of the interface.
#
# [*nic*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface has the given name. The name of a network interface (e.g. eth0, eth1, lo). An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*nic_match*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface has a name that matches the given regular expression. Value is a regular expression against which the names of the network interfaces available on the machine can be matched to find an acceptable interface. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*not*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be that the IP address *does not* meet any of a nested set of criteria. The value of the attribute is a set of criteria (e.g. 'loopback') whose normal meaning is reversed. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*point_to_point*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not its network interface is a point-to-point interface. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*public_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not it is a publicly routable address. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*resolved_address*]
#   Attribute showing the resolved ip address for this interface.
#
# [*site_local_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or it is a site-local address. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*subnet_match*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or it the address fits in the given subnet definition. Value is a network IP address and the number of bits in the address' network prefix, written in "slash notation"; e.g. "192.168.0.0/16". An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*up*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface is currently up. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*virtual*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface is a virtual interface. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
#
define jboss_admin::resource::interface (
  $server,
  $any                            = undef,
  $any_address                    = undef,
  $any_ipv4_address               = undef,
  $any_ipv6_address               = undef,
  $inet_address                   = undef,
  $link_local_address             = undef,
  $loopback                       = undef,
  $loopback_address               = undef,
  $multicast                      = undef,
  $resource_name                  = undef,
  $nic                            = undef,
  $nic_match                      = undef,
  $not                            = undef,
  $point_to_point                 = undef,
  $public_address                 = undef,
  $resolved_address               = undef,
  $site_local_address             = undef,
  $subnet_match                   = undef,
  $up                             = undef,
  $virtual                        = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

    if $any_address != undef and !is_bool($any_address) { 
      fail('The attribute any_address is not a boolean') 
    }
    if $any_ipv4_address != undef and !is_bool($any_ipv4_address) { 
      fail('The attribute any_ipv4_address is not a boolean') 
    }
    if $any_ipv6_address != undef and !is_bool($any_ipv6_address) { 
      fail('The attribute any_ipv6_address is not a boolean') 
    }
    if $inet_address != undef and !is_string($inet_address) { 
      fail('The attribute inet_address is not a string') 
    }
    if $link_local_address != undef and !is_bool($link_local_address) { 
      fail('The attribute link_local_address is not a boolean') 
    }
    if $loopback != undef and !is_bool($loopback) { 
      fail('The attribute loopback is not a boolean') 
    }
    if $loopback_address != undef and !is_string($loopback_address) { 
      fail('The attribute loopback_address is not a string') 
    }
    if $multicast != undef and !is_bool($multicast) { 
      fail('The attribute multicast is not a boolean') 
    }
    if $resource_name != undef and !is_string($resource_name) { 
      fail('The attribute resource_name is not a string') 
    }
    if $nic != undef and !is_string($nic) { 
      fail('The attribute nic is not a string') 
    }
    if $nic_match != undef and !is_string($nic_match) { 
      fail('The attribute nic_match is not a string') 
    }
    if $point_to_point != undef and !is_bool($point_to_point) { 
      fail('The attribute point_to_point is not a boolean') 
    }
    if $public_address != undef and !is_bool($public_address) { 
      fail('The attribute public_address is not a boolean') 
    }
    if $resolved_address != undef and !is_string($resolved_address) { 
      fail('The attribute resolved_address is not a string') 
    }
    if $site_local_address != undef and !is_bool($site_local_address) { 
      fail('The attribute site_local_address is not a boolean') 
    }
    if $subnet_match != undef and !is_string($subnet_match) { 
      fail('The attribute subnet_match is not a string') 
    }
    if $up != undef and !is_bool($up) { 
      fail('The attribute up is not a boolean') 
    }
    if $virtual != undef and !is_bool($virtual) { 
      fail('The attribute virtual is not a boolean') 
    }
  

    $raw_options = { 
      'any'                          => $any,
      'any-address'                  => $any_address,
      'any-ipv4-address'             => $any_ipv4_address,
      'any-ipv6-address'             => $any_ipv6_address,
      'inet-address'                 => $inet_address,
      'link-local-address'           => $link_local_address,
      'loopback'                     => $loopback,
      'loopback-address'             => $loopback_address,
      'multicast'                    => $multicast,
      'name'                         => $resource_name,
      'nic'                          => $nic,
      'nic-match'                    => $nic_match,
      'not'                          => $not,
      'point-to-point'               => $point_to_point,
      'public-address'               => $public_address,
      'resolved-address'             => $resolved_address,
      'site-local-address'           => $site_local_address,
      'subnet-match'                 => $subnet_match,
      'up'                           => $up,
      'virtual'                      => $virtual,
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
