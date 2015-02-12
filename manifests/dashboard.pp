# == Class: role_sensu::dashboard
#
class role_sensu::dashboard (
  $uchiwa_api_config = $role_sensu::yaml::parameters['role_sensu::dashboard::uchiwa_api_config'],
  $uchiwa_user       = 'admin',
  $uchiwa_pass       = 'secret',
  ) {

  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    user                => $uchiwa_user,
    pass                => $uchiwa_pass,
    install_repo        => false
  }

}
