# == Class: role_sensu::client
#
class role_sensu::client (
  $rabbitmq_password,
  $sensu_server,
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
  
  sensu::check { 'check_cron':
    command     => '/bin/ps -aux | grep -v grep | grep cron',
    handlers    => 'default',
    subscribers => 'sensu-test-rudi'
  }
  
}
