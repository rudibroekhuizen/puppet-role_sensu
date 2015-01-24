# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password = 'secret',
  $sensu_server      = '172.16.3.15',
  ) {
  
  class { 'sensu':
    rabbitmq_password    => $rabbitmq_password,
    rabbitmq_host        => $sensu_server,
    rabbitmq_vhost       => '/sensu',
    subscriptions        => 'sensu-test-rudi',
  }
 
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
