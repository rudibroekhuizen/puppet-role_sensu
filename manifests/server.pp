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
  
  # check-procs.rb will run on clients, where subscriptions is 'sensu-test-rudi'
  # check-procs.rb file must be available on sensu-server, not on sensu-client
  sensu::check { "check-procs_cron":
    command     => '/opt/sensu-community-plugins/plugins/processes/check-procs.rb -p cron -C 1 ',
    handlers    => 'default',
    subscribers => 'sensu-test-rudi',
    standalone  => false,
    publish     => true,
  }
  
}
