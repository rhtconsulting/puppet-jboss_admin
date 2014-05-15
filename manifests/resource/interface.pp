# == Defines jboss_admin::interface
#
# A named network interface, along with required criteria for determining the IP address to associate with that interface.
#
# === Parameters
#
# [*up*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface is currently up. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*any_address*]
#   Attribute indicating that sockets using this interface should be bound to a wildcard address. The IPv6 wildcard address (::) will be used unless the java.net.preferIpV4Stack system property is set to true, in which case the IPv4 wildcard address (0.0.0.0) will be used. If a socket is bound to an IPv6 anylocal address on a dual-stack machine, it can accept both IPv6 and IPv4 traffic; if it is bound to an IPv4 (IPv4-mapped) anylocal address, it can only accept IPv4 traffic.
#
# [*public_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not it is a publicly routable address. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*loopback_address*]
#   Attribute indicating that the IP address for this interface should be the given value, if a loopback interface exists on the machine. A 'loopback address' may not actually be configured on the machine's loopback interface. Differs from inet-address in that the given value will be used even if no NIC can be found that has the IP specified address associated with it. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*virtual*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface is a virtual interface. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*any_ipv4_address*]
#   Attribute indicating that sockets using this interface should be bound to the IPv4 wildcard address (0.0.0.0).
#
# [*site_local_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or it is a site-local address. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
# [*loopback*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not it is a loopback address.  An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*any*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be that the IP address meets at least one of a nested set of criteria, but not necessarily all of the nested criteria. The value of the attribute is a set of criteria. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*any_ipv6_address*]
#   Attribute indicating that sockets using this interface should be bound to the IPv6 wildcard address (::).
#
# [*subnet_match*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or it the address fits in the given subnet definition. Value is a network IP address and the number of bits in the address' network prefix, written in "slash notation"; e.g. "192.168.0.0/16". An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*not*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be that the IP address *does not* meet any of a nested set of criteria. The value of the attribute is a set of criteria (e.g. 'loopback') whose normal meaning is reversed. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*inet_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not the address matches the given value. Value is either a IP address in IPv6 or IPv4 dotted decimal notation, or a hostname that can be resolved to an IP address. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*name*]
#   The name of the interface.
#
# [*multicast*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not its network interface supports multicast.  An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*nic_match*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface has a name that matches the given regular expression. Value is a regular expression against which the names of the network interfaces available on the machine can be matched to find an acceptable interface. An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*link_local_address*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not the address is link-local. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection.
#
# [*nic*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether its network interface has the given name. The name of a network interface (e.g. eth0, eth1, lo). An 'undefined' value means this attribute is not relevant to the IP address selection.
#
# [*point_to_point*]
#   Attribute indicating that part of the selection criteria for choosing an IP address for this interface should be whether or not its network interface is a point-to-point interface. An 'undefined' or 'false' value means this attribute is not relevant to the IP address selection
#
#
define jboss_admin::resource::interface (
  $server,
  $up                             = undef,
  $any_address                    = undef,
  $public_address                 = undef,
  $loopback_address               = undef,
  $virtual                        = undef,
  $any_ipv4_address               = undef,
  $site_local_address             = undef,
  $loopback                       = undef,
  $any                            = undef,
  $any_ipv6_address               = undef,
  $subnet_match                   = undef,
  $not                            = undef,
  $inet_address                   = undef,
  $name                           = undef,
  $multicast                      = undef,
  $nic_match                      = undef,
  $link_local_address             = undef,
  $nic                            = undef,
  $point_to_point                 = undef,
  $ensure                         = present,
  $path                           = $name
) {
  if $ensure == present {

  

    $raw_options = { 
      'up'                           => $up,
      'any-address'                  => $any_address,
      'public-address'               => $public_address,
      'loopback-address'             => $loopback_address,
      'virtual'                      => $virtual,
      'any-ipv4-address'             => $any_ipv4_address,
      'site-local-address'           => $site_local_address,
      'loopback'                     => $loopback,
      'any'                          => $any,
      'any-ipv6-address'             => $any_ipv6_address,
      'subnet-match'                 => $subnet_match,
      'not'                          => $not,
      'inet-address'                 => $inet_address,
      'name'                         => $name,
      'multicast'                    => $multicast,
      'nic-match'                    => $nic_match,
      'link-local-address'           => $link_local_address,
      'nic'                          => $nic,
      'point-to-point'               => $point_to_point,
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
