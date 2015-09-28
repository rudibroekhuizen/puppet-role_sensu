# == Class: role_sensu::server
#
class role_sensu::server {
  
  class { 'redis': } ->

  class { 'role_sensu::rabbitmq': } ->

  class { 'sensu':
    install_repo      => true,
    server            => true,
    manage_services   => true,
    manage_user       => true,
    rabbitmq_password => $role_sensu::rabbitmq_password,
    rabbitmq_vhost    => '/sensu',
    api               => true,
    api_user          => $role_sensu::api_user,
    api_password      => $role_sensu::api_password,
    use_embedded_ruby => true,  # /opt/sensu/embedded/bin/ruby 
  }
  
  # Install Git and download sensu community plugins
  package { 'git':
    ensure  => installed
  }
  
  # Create checks hiera yaml input
  class { 'role_sensu::checks':
  }
  
  # Create handlers
  class { 'role_sensu::handlers':
  }
  
  # Install plugins
  class { 'role_sensu::plugins':
  }
  
   # Install uchiwa webinterface
  class { 'role_sensu::dashboard':
  }
  
}
