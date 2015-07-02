# == Class: role_sensu::handlers
#
class role_sensu::handlers {

  # Needed by mailer handler: /opt/sensu/embedded/bin/gem install mail --no-ri --no-rdoc -v 2.5.4 
  package { mail:
    ensure          => "2.5.4",
    provider        => gem,
    install_options => [{"--install-dir" => "/opt/sensu/embedded/lib/ruby/gems/2.0.0"}],
  } 

  # Configure handlers 
  create_resources( 'sensu::handler', $role_sensu::handlers_hash )

}
