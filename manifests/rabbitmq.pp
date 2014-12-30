# == Class: role_sensu::rabbitmq.pp
#
class role_sensu::rabbitmq.pp {

  class {'::rabbitmq':
    delete_guest_user => true,
  }
  
}
