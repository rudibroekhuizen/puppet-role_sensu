# == Class: role_sensu::rabbitmq.pp
#
class role_sensu::rabbitmq.pp {

  Exec { path => [ "/opt/rabbitmq/sbin", "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
  
  class {'::rabbitmq':
    delete_guest_user => true,
  }
 
  $sensu_passwd = hiera('rq::sensu')  

  exec { "vhost-sensu":
    command => "rabbitmqctl add_vhost /sensu",
    unless  => "rabbitmqctl list_vhosts | grep sensu",
  }

  exec { "user-sensu":
    command => "rabbitmqctl add_user sensu $sensu_passwd",
    unless  => "rabbitmqctl list_users | grep sensu",
  }

  #exec { "tags-sensu":
  #  command => "rabbitmqctl set_user_tags sensu administrator",
  #  unless  => "rabbitmqctl list_users | grep sensu",
  #}

  exec { "perm-sensu":
    command => 'rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"',
    unless  => "rabbitmqctl list_permissions -p /sensu | grep -E 'sensu.*\.\*.*\.\*.*\.\*'",
    require => [Exec['user-sensu'],Exec['vhost-sensu']]
  }    

}
