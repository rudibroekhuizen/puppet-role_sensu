# == Class: role_sensu::install_uchiwa
#
class role_sensu::install_uchiwa (
  $uchiwa_api_config = [{
                          host     => $::ipaddress,
                          ssl      => false,
                          insecure => false,
                          port     => 4567,
                          user     => 'sensu',
                          pass     => 'sensu',
                          path     => '',
                          timeout  => 5
                        }]

  ) {

  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
  }

}
