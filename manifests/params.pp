# == Class: role_sensu::params
#
class role_sensu::params {
  $rabbitmq_password = $role_sensu::parameters['role_sensu::server::server::rabbitmq_password'],
}
