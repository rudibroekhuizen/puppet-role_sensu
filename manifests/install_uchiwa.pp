# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa (
  $uchiwa_api_config = [{
                          host     => '127.0.0.1',
                          ssl      => false,
                          insecure => true,
                          port     => 4567,
                          user     => 'admin',
                          pass     => 'secret',
                          path     => '/sensu',
                          timeout  => 5
                        }]

  ) {

  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user     => 'admin',
    pass     => 'secret',
  }

}
