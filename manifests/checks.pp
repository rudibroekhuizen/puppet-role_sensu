# == Class: role_sensu::checks
#
class role_sensu::checks {

  create_resources( 'sensu::check', $role_sensu::checks_hash, $role_sensu::checks_defaults )

}
