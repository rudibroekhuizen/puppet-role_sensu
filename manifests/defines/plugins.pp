# == Define: role_sensu::defines::plugins
#
define role_sensu::defines::plugins (
  $version = undef,
) {

  package { $title:
    ensure          => $version,
    provider        => gem,
    install_options => [{"--install-dir" => "/opt/sensu/embedded/lib/ruby/gems/2.0.0"}],
  } 

}
