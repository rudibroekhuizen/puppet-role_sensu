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
  
  package { 'sensu-plugin':
    ensure   => installed,
    provider => gem,
  }
  
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
