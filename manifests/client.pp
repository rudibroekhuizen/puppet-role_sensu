# == Class: role_sensu::client.pp
#
class role_sensu::client.pp (
  $rabbitmq_password,
  $sensu_server,
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
