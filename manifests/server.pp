# == Class: role_sensu::server.pp
#
class role_sensu::server.pp (
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
    command => 'mail -s \'sensu alert\' ops@example.com',
  }

  sensu::check { "check_cron":
    command => '/opt/sensu-community-plugins/plugins/system/check_cron.rb',
  }
  
}
