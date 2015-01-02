# == Class: role_sensu::uchiwa
#
# Based on https://github.com/sensu/sensu-puppet/blob/master/tests/uchiwa.pp
#
class role_sensu::uchiwa {

  package { 'uchiwa':
    ensure => present,
  }

  file { '/etc/sensu/uchiwa.json':
    ensure  => present,
    content => '
  {
    "sensu": [
      {
        "name": "Site1",
        "host": "localhost",
        "port": 4567,
        "timeout": 5,
        "user": "admin",
        "pass": "secret"
      }
    ],
    "uchiwa": {
      "host": "0.0.0.0",
      "port": 3000,
      "user": "uchiwa",
      "pass": "uchiwa",
      "interval": 5
    }
  }',
    require => Package['uchiwa'],
    notify  => Service['uchiwa'],
  }

  service { 'uchiwa':
    ensure  => running,
    require => [ File['/etc/sensu/uchiwa.json'],Package['uchiwa'] ]
  }
  
}
