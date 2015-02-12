# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password = $role_sensu::yaml::parameters['role_sensu::client::rabbitmq_password'],
  $sensu_server      = $role_sensu::yaml::parameters['role_sensu::client::sensu_server'],
  $subscriptions     = $role_sensu::yaml::parameters['role_sensu::client::subscriptions'],
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
