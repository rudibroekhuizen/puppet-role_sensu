# == Class: role_sensu::client
#
class role_sensu::client {
  
  class { 'sensu':
    rabbitmq_vhost    => '/sensu',
    rabbitmq_password => $role_sensu::rabbitmq_password,
    rabbitmq_host     => $role_sensu::sensu_server,
    subscriptions     => $role_sensu::subscriptions,
  }
 
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
