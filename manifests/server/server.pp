# == Class: role_sensu::server::server
#
class role_sensu::server::server (
  $api_user          = 'api_user',
  $api_password      = 'secret',
  ) {
 
  bla = $role_sensu::server::rabbitmq::rabbitmq_password
  
  notice( "$role_sensu::server::rabbitmq::rabbitmq_password" ) 
 
  class { 'redis': } ->

  #class { 'role_sensu::server::rabbitmq': } ->

  class { 'sensu':
    install_repo      => true,
    server            => true,
    manage_services   => true,
    manage_user       => true,
    rabbitmq_password => 'bla',
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
  class { 'role_sensu::server::handlers':
  }

}
