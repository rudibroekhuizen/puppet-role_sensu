# == Class: role_sensu::server
#
class role_sensu::server {
  
  class { 'redis': } ->

  class { 'role_sensu::rabbitmq': } ->

  # Use Sensu SSL tool to generate certificates
  class { 'sensu':
    install_repo             => true,
    server                   => true,
    manage_services          => true,
    manage_user              => true,
    rabbitmq_password        => $role_sensu::rabbitmq_password,
    rabbitmq_ssl_cert_chain  => '/etc/sensu/ssl/cert.pem',
    rabbitmq_ssl_private_key => '/etc/sensu/ssl/key.pem',
    rabbitmq_host            => 'localhost',
    rabbitmq_vhost           => '/sensu',
    api                      => true,
    api_user                 => $role_sensu::api_user,
    api_password             => $role_sensu::api_password,
    use_embedded_ruby        => true,  # /opt/sensu/embedded/bin/ruby 
    subscriptions            => $role_sensu::subscriptions,
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
  class { 'role_sensu::uchiwa':
  }
  
}
