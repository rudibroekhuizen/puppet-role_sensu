# == Class: role_sensu::server
#
class role_sensu::server (
  $rabbitmq_password = $role_sensu::parameters['role_sensu::server::rabbitmq_password'],
  $api_user          = 'api_user',
  $api_password      = 'secret',
  ) {
  include role_sensu
  
  
  #$rabbitmq_password = $::rabbitmq_password
  
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
    use_embedded_ruby => true,  # /opt/sensu/embedded/bin/ruby 
  }
  
  # Download sensu community plugins
  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins',
  }
  
  # Create checks hiera yaml input
  class { 'role_sensu::checks':
  }
  
  # Create handlers
  class { 'role_sensu::handlers':
  }

}
