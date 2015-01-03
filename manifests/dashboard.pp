# == Class: role_sensu::dashboard
#
class role_sensu::dashboard (
  $uchiwa_api_config = [ { name     => 'sensu-01',
                           host     => 'localhost',
                           ssl      => false,
                           insecure => false,
                           port     => 4567,
                           user     => 'admin',  #api_user
                           pass     => 'secret', #api_password
                           timeout  => 5
                          } ],
  $uchiwa_user = 'admin',
  $uchiwa_pass = 'secret',
  ) {

  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user                => $uchiwa_user,
    pass                => $uchiwa_pass,
  }

}