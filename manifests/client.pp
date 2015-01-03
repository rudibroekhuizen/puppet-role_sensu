# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password = 'secret',
  $sensu_server      = '172.16.3.14',
  ) {
  
  # Ruby-dev is needed for sensu-plugin
  package { 'ruby-dev':
    ensure => installed,
  } ->
  
  # Make is needed for ruby-dev
  package { 'make':
    ensure => installed,
  } ->

  class { 'sensu':
    rabbitmq_password    => $rabbitmq_password,
    rabbitmq_host        => $sensu_server,
    rabbitmq_vhost       => '/sensu',
    subscriptions        => 'sensu-test-rudi',
    sensu_plugin_version => installed,           #gem install sensu-plugin
    #subscriptions       => 'all',
    #client_address      => $::ipaddress_eth1,
  }
 
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
