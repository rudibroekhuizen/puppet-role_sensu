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
  $mode = "server",
  ) {
  include role_sensu::yaml            # load yaml file if hiera is not available (the Foreman for example)
  include apt                         # this solves error "class apt has not been evaluated"
  
  if $mode == "server" {
    class { 'role_sensu::server': }
  
  } elsif $mode == "client" {
      class { 'role_sensu::client': 
      }

    } else {
        fail ( "set mode option: client or server" )
  }
  
}
