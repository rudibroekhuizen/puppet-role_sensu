# == Class: role_sensu::rabbitmq
#
# Based on https://github.com/sensu/sensu-puppet/blob/master/tests/rabbitmq.sh
#
class role_sensu::rabbitmq (
  $sensu_passwd = 'Passw0rd', 
  ) {

  Exec { 
    path => [ "/opt/rabbitmq/sbin", "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
  }
  
  class {'::rabbitmq':
    delete_guest_user => true,
  }
 
  exec { "vhost-sensu":
    command => "rabbitmqctl add_vhost sensu",
    unless  => "rabbitmqctl list_vhosts | grep sensu",
    require => Class['::rabbitmq']
  }

  exec { "user-sensu":
    command => "rabbitmqctl add_user sensu $sensu_passwd",
    unless  => "rabbitmqctl list_users | grep sensu",
    require => Class['::rabbitmq']
  }

  exec { "tags-sensu":
    command => "rabbitmqctl set_user_tags sensu administrator",
    unless  => "rabbitmqctl list_users | grep administrator",
    require => [Class['::rabbitmq'], Exec['user-sensu']]
  }

  exec { "perm-sensu":
    command => 'rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"',
    unless  => 'rabbitmqctl list_permissions -p /sensu | grep -E \'sensu.*\.\*.*\.\*.*\.\*'\',
    require => [Class['::rabbitmq'], Exec['vhost-sensu'], Exec['user-sensu']]
  }    

}
