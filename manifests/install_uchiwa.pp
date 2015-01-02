# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa {
  
  class { 'uchiwa':
    host => $::ipaddress,
  }

}
