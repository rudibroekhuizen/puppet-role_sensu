# == Class: role_sensu::params
#
class role_sensu::params {
  $deployment = 'foreman'
  
  case $deployment {
    'foreman': { 
      $parameters = parseyaml(file('/etc/puppet/hieradata/server-test.yaml')),
      $configfile = $parameters['role_test::configfile']
    }
    'default': {
      $configfile = 'logstash-snmpget-01.conf'
    }
  }
  
}
