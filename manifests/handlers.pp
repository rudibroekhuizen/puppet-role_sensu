# == Class: role_sensu::handlers
#
class role_sensu::handlers {

  package { 'mail':
    ensure   => installed,
    provider => 'gem'
  }

  sensu::handler { 'mailer':
    type        => 'pipe',
    source      => 'puppet:///modules/sensu-community-plugins/handlers/notification/mailer.rb',
    config      => {
      mail_from     => "sensu-rudi@naturalis.nl",
      mail_to       => "rudi.broekhuizen@naturalis.nl",
      smtp_address  => "aspmx.l.google.com",
      smtp_port     => 25,
      smtp_domain   => "naturalis.nl",
    },
  }
}
