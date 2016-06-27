# == Class: role_sensu::client
#
class role_sensu::client {

  file { '/etc/sensu/ssl/cert.pem':
    ensure  => present,
    content => $role_sensu::cert,
    mode    => '0644',
  }

  file { '/etc/sensu/ssl/key.pem':
    ensure  => present,
    content => $role_sensu::key,
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
