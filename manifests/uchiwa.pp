# == Class: role_sensu::uchiwa
#
class role_sensu::uchiwa {

  # Install uchiwa, username and password for uchiwa webinterface, port 3000.
  class { '::uchiwa':
    sensu_api_endpoints => $role_sensu::uchiwa_api_config,
    user                => $role_sensu::uchiwa_user,
    pass                => $role_sensu::uchiwa_pass,
    install_repo        => false            # otherwise you get this: Apt::Source[sensu] is already declared in file /etc/puppet/modules/sensu/manifests/repo/apt.pp
  }

  # If using uchiwa ssl settings: "bind: permission denied"; using nginx
  class {'::nginx': }

  nginx::resource::upstream { 'sensu':
    members => ['localhost:3000'],
  }

  nginx::resource::vhost { 'sensu':
    proxy       => 'http://localhost:3000',
    ssl         => true,
    listen_port => 443,
    ssl_cert    => '/etc/sensu/ssl/uchiwa.pem',
    ssl_key     => '/etc/sensu/ssl/uchiwa.key',
  }

}