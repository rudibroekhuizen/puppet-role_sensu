# == Class: role_sensu::checks
#
class role_sensu::checks (
  $checks_hash = $role_sensu::yaml::parameters['role_sensu::checks::checks_hash'],
  $checks_defaults = $role_sensu::yaml::parameters['role_sensu::checks::checks_defaults'],
  ){

  create_resources('sensu::check', $checks_hash, $checks_defaults)
}


# If hiera is available:
# $checks_hash,
# $checks_defaults,
