# == Class: role_sensu::server
#
class role_sensu::server (
  $rabbitmq_password = 'secret',
  $api_user          = 'admin',
  $api_password      = 'secret',
  $uchiwa_api_config = [ { host     => 'localhost',
                           ssl      => false,
                           insecure => false,
                           port     => 4567,
                           user     => $api_user,
                           pass     => $api_pass,
                           timeout  => 5
                          } ],
  $uchiwa_user = 'admin',
  $uchiwa_pass = 'secret',
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
    api_user          => $api_user,
    api_password      => $api_pass,
    #client_address    => $::ipaddress_eth1
  } ->

  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user                => $uchiwa_user,
    pass                => $uchiwa_pass,
  }

  # Example handler
  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }
  
  # download sensu community plugins
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
  # Example check: is cron service running
  # check-procs.rb will run on clients, where subscriptions is 'sensu-test-rudi'
  # check-procs.rb file must be available on sensu-client
  sensu::check { "check-procs_cron":
    command     => '/opt/sensu-community-plugins/plugins/processes/check-procs.rb -p cron -C 1 ',
    handlers    => 'default',
    subscribers => 'sensu-test-rudi',
    standalone  => false,
    publish     => true,
  }
  
}
