# == Class: role_sensu::rabbitmq
#
class role_sensu::rabbitmq {

  class {'::rabbitmq':
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
