# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa (
  $uchiwa_api_config = [ { host     => 'localhost',
                           ssl      => false,
                           insecure => false,
                           port     => 4567,
                           user     => 'admin',
                           pass     => 'secret',
                           timeout  => 5
                          } ],
  $uchiwa_user = 'admin',
  $uchiwa_pass = 'admin',

  ) {

  # username and password for uchiwa webinterface, port 3000
  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user                => $uchiwa_user,
    pass                => $uchiwa_pass,
  }

}
