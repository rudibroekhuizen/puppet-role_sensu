# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password,
  $sensu_server,
  ) {

  class { 'sensu':
    rabbitmq_password    => $rabbitmq_password,
    rabbitmq_host        => $sensu_server,
    rabbitmq_vhost       => '/sensu',
    subscriptions        => 'sensu-test-rudi',
    sensu_plugin_version => installed,
    #subscriptions       => 'all',
    #client_address      => $::ipaddress_eth1,
  }
  
  #package { 'sensu-plugin':
  #  ensure   => installed,
  #  provider => gem,
  #}
  
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
