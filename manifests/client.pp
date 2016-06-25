# == Class: role_sensu::client
#
class role_sensu::client {
  
  # Create private key file for rabbitmq communication between client and server:
  file { '/etc/sensu/ssl/private_key.pem':
    ensure  => present,
    content => $role_sensu::private_key,
    mode    => '0644',
  }
  
  # Create cert chain file:
  file { '/etc/sensu/ssl/cert_chain.pem':
    ensure  => present,
    content => $role_sensu::cert_chain,
    mode    => '0644',
  }

  class { 'sensu':
    rabbitmq_vhost    => '/sensu',
    rabbitmq_password => $role_sensu::rabbitmq_password,
    rabbitmq_host     => $role_sensu::sensu_server,
    subscriptions     => $role_sensu::subscriptions,
  }
 
  # Install plugins
  class { 'role_sensu::plugins':
  }
  
}
