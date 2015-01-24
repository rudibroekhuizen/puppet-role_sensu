# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password = 'secret',
  $sensu_server      = '172.16.3.15',
  $subscriptions     = 'sub-001',
  ) {
  
  class { 'sensu':
    rabbitmq_vhost    => '/sensu',
    rabbitmq_password => $rabbitmq_password,
    rabbitmq_host     => $sensu_server,
    subscriptions     => $subscriptions,
  }
 
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
