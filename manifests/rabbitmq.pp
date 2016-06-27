# == Class: role_sensu::rabbitmq
#
class role_sensu::rabbitmq {

  class {'::rabbitmq':
    ssl_key           => '/etc/rabbitmq/ssl/key.pem',
    ssl_cert          => '/etc/rabbitmq/ssl/cert.pem',
    ssl_cacert        => '/etc/rabbitmq/ssl/cacert.pem',
    ssl               => true,
    delete_guest_user => true,
  }

  rabbitmq_vhost { '/sensu': }

  rabbitmq_user { 'sensu': 
    password => $role_sensu::rabbitmq_password
  }

  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

}
