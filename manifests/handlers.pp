# == Class: role_sensu::handlers
#
class role_sensu::handlers {

  package { mail:
    ensure          => installed,
    provider        => gem,
    install_options => [{"--install-dir" => "/opt/sensu/embedded/lib/ruby/gems/2.0.0/gems","-v" => "2.5.4"}],
  } 

  sensu::handler { 'default':
    command => 'echo "sensu alert" >> /tmp/sensu.log',
  }

  sensu::handler { 'mailer':
    type    => 'pipe',
    command => '/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/handlers/notification/mailer.rb',
    config  => {
      mail_from    => "sensu-rudi@naturalis.nl",
      mail_to      => "rudi.broekhuizen@naturalis.nl",
      smtp_address => "aspmx.l.google.com",
      smtp_port    => 25,
      smtp_domain  => "naturalis.nl",
    },
  }
}
