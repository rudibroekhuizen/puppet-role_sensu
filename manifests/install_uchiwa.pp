# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa (
  $uchiwa_api_config = [{
                          host     => 0.0.0.0,
                          ssl      => false,
                          insecure => true,
                          port     => 4567,
                          user     => 'sensu',
                          pass     => 'Passw0rd',
                          path     => '/sensu',
                          timeout  => 5
                        }]

  ) {

  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
  }

}
