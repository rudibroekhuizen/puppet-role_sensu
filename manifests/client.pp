# == Class: role_sensu::client
#
class role_sensu::client {

  # Use Sensu SSL tool to generate certificates
  class { 'sensu':
    purge_config             => true,
    rabbitmq_vhost           => '/sensu',
    rabbitmq_ssl_cert_chain  => '/etc/sensu/ssl/cert.pem',
    rabbitmq_ssl_private_key => '/etc/sensu/ssl/key.pem',
    rabbitmq_password        => $role_sensu::rabbitmq_password,
    rabbitmq_host            => $role_sensu::sensu_server,
    subscriptions            => $role_sensu::subscriptions,
  }
 
  # Install plugins
  class { 'role_sensu::plugins':
  }
  
}
