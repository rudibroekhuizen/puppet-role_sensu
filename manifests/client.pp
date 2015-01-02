# == Class: role_sensu::client.pp
#
class role_sensu::client.pp (
  $sensu_server,
  $rabbitmq_password,
  ) {

  class { 'sensu':
    rabbitmq_password => $rabbitmq_password,
    rabbitmq_host     => $sensu_server,
    rabbitmq_vhost    => '/sensu',
    subscriptions     => 'sensu-test-rudi',
    #subscriptions    => 'all',
    #client_address   => $::ipaddress_eth1,
  }
  
}
