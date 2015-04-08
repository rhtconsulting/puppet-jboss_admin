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
  $cli_path                       = $name
) {
  if $ensure == present {

    if $any_address != undef and $any_address != undefined {
      validate_bool($any_address)
    }
    if $any_ipv4_address != undef and $any_ipv4_address != undefined {
      validate_bool($any_ipv4_address)
    }
    if $any_ipv6_address != undef and $any_ipv6_address != undefined {
      validate_bool($any_ipv6_address)
    }
    if $link_local_address != undef and $link_local_address != undefined {
      validate_bool($link_local_address)
    }
    if $loopback != undef and $loopback != undefined {
      validate_bool($loopback)
    }
    if $multicast != undef and $multicast != undefined {
      validate_bool($multicast)
    }
    if $point_to_point != undef and $point_to_point != undefined {
      validate_bool($point_to_point)
    }
    if $public_address != undef and $public_address != undefined {
      validate_bool($public_address)
    }
    if $site_local_address != undef and $site_local_address != undefined {
      validate_bool($site_local_address)
    }
    if $up != undef and $up != undefined {
      validate_bool($up)
    }
    if $virtual != undef and $virtual != undefined {
      validate_bool($virtual)
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
