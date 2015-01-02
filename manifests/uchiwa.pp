# == Class: role_sensu::uchiwa
#
class role_sensu::uchiwa (
  $uchiwa_api_config = [{
                          host     => '127.0.0.1',
                          ssl      => true,
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
