# == Class: role_sensu::server::handlers
#
class role_sensu::server::handlers {

  # Needed by mailer handler: /opt/sensu/embedded/bin/gem install mail --no-ri --no-rdoc -v 2.5.4 
  package { mail:
    ensure          => "2.5.4",
    provider        => gem,
    install_options => [{"--install-dir" => "/opt/sensu/embedded/lib/ruby/gems/2.0.0"}],
  } 

  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }

  sensu::handler { 'mailer':
    command => '/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/handlers/notification/mailer.rb',
    config  => {
      mail_from    => "sensu@naturalis.nl",
      mail_to      => "rudi.broekhuizen@naturalis.nl",
      smtp_address => "aspmx.l.google.com",
      smtp_port    => 25,
      smtp_domain  => "naturalis.nl",
    },
  }
}