# == Class: role_sensu::server
#
class role_sensu::server (
  $rabbitmq_password = 'secret',
  $api_user          = 'api_user',
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
    use_embedded_ruby => true,  # if set to false you need add this before every command: /opt/sensu/embedded/bin/ruby
  }
  
  # Create checks hiera yaml input
  class { 'role_sensu::checks': }
  
  # Create handlers
  class { 'role_sensu::handlers': }
  
  # Download sensu community plugins
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
}
