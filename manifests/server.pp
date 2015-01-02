# == Class: role_sensu::server
#
class role_sensu::server (
  $rabbitmq_password,
  ) {

  class { 'redis': } ->

  class { 'role_sensu::rabbitmq': } ->

  class { 'sensu':
    install_repo      => true,
    server            => true,
    manage_services   => true,
    manage_user       => true,
    rabbitmq_password => $rabbitmq_password,
    rabbitmq_vhost    => '/sensu',
    api               => true,
    api_user          => 'admin',
    api_password      => 'secret',
    #client_address    => $::ipaddress_eth1
  }

  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }

  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
  sensu::check { "cron_check":
    command     => '/opt/sensu-community-plugins/plugins/system/check-procs.rb -p crond -C 1 ',
    handlers    => 'default',
    subscribers => 'sensu-test-rudi',
    #standalone  => false,
    publish     => true,
  }
  
}
