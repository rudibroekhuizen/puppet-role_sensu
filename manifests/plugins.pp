# == Class: role_sensu::plugins
#
class role_sensu::plugins {

  create_resources('role_sensu::defines::plugins', $role_sensu::plugins_hash)
  
}
