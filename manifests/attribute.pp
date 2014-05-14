# = Defines jboss_admin::attribute
define jboss_admin::attribute (
  $address,
  $attribute,
  $value,
  $server
) {
  $server_base_path = getparam($server, 'base_path')
  $cli_path         = "${server_base_path}/bin/cli.sh"
  $cli_base         = "${cli_path} --connect --commands="

  $read_command ="${address}:read-attribute(name=${attribute})"
  $parse_value  ="grep -e \"=> ${value}$\" | wc -l"
  $write_command="${address}:write-attribute(name=${attribute},value=${value})"

  exec {"${name}_SetAttribute":
    unless  => "${cli_base}${read_command} | ${parse_value}",
    command => "${cli_base}${write_command}"
  }
}
