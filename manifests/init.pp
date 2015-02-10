# == Class: role_sensu
#
# Full description of class role_sensu here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'role_sensu':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_sensu (
  $data_source = '
---
role_sensu::server::rabbitmq::rabbitmq_password:
  secret

role_sensu::server::server::rabbitmq_password:
  secret

role_sensu::server::server::api_user:
  api_user
  
role_sensu::server::server::api_password:
  secret
  
role_sensu::server::dashboard::uchiwa_user:
  ictsupport
  
role_sensu::server::dashboard::uchiwa_pass:
  ictsupport

role_sensu::server::dashboard::uchiwa_api_config:
  - name: ICTSUPPORT
    host: localhost
    ssl: false
    insecure: false
    port: 4567
    user: api_user
    pass: secret
    timeout: 5

role_sensu::checks::checks_defaults:
  handlers:
    - default
    - mailer
  standalone: false

role_sensu::checks::checks_hash:
  check-procs_cron:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/processes/check-procs.rb -p cron -C 1 "
    subscribers: "sub-001"
    handlers:
      - default
      - mailer
  
  check-disk:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/system/check-disk.rb"
    subscribers: "sub-001"

  check-http_www_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.naturalis.nl/nl/ -q \'Bezoekersinfo\'"
    subscribers: "sub-001"

  check-http_crs_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://crs.naturalis.nl/Atlantisweb/pages/publiek/Login.aspx?lastURL=http%3a%2f%2fcrs.naturalis.nl%2fAtlantisweb -q \'Naturalis   Biodiversity Center - Log in\'"
    subscribers: "sub-001"

') {

  $parameters = parseyaml($data_source)
  notice( "$data_source" )
  notice( "$parameters" ) 
  notice( "$configfile" )

}
