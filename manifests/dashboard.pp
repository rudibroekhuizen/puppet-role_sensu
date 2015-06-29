# == Class: role_sensu::dashboard
#
class role_sensu::dashboard {

  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { 'uchiwa':
    sensu_api_endpoints => $role_sensu::uchiwa_api_config,
    user                => $role_sensu::uchiwa_user,
    pass                => $role_sensu::uchiwa_pass,
    install_repo        => false            # otherwise you get this: Apt::Source[sensu] is already declared in file /etc/puppet/modules/sensu/manifests/repo/apt.pp
  }

}
