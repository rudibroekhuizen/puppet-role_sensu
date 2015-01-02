# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa (
  $uchiwa_api_config = [{
                          host     => 10.42.1.151,
                          ssl      => false,
                          insecure => true,
                          port     => 4567,
                          user     => 'sensu',
                          pass     => 'sensu',
                          path     => '/sensu',
                          timeout  => 5
                        }]

  ) {

  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
  }

}
