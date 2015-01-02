# == Class: role_sensu::dashboard
#
class role_sensu::dashboard (
  $test = $role_sensu::server::api_user,
  $uchiwa_api_config = [ { host     => 'localhost',
                           ssl      => false,
                           insecure => false,
                           port     => 4567,
                           user     => $test,
                           pass     => 'secret',
                           timeout  => 5
                          } ],
  $uchiwa_user = 'admin',
  $uchiwa_pass = 'secret',

  ) {

  include role_sensu::server
  
  
  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user                => $uchiwa_user,
    pass                => $uchiwa_pass,
  }

}
