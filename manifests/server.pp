# == Class: role_sensu::server
#
class role_sensu::server (
  $rabbitmq_password = 'secret',
  $api_user          = 'admin',
  $api_password      = 'secret',
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
    api_password      => $api_password,
  }
  
  # Create checks
  class { 'role_sensu::checks': }
  
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
  
}
