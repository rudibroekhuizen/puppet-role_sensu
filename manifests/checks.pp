# == Class: role_sensu::checks
#
class role_sensu::checks (
  $checks_hash,
  $checks_defaults,
  ){

  create_resources('sensu::check', $checks_hash, $checks_defaults)
}
