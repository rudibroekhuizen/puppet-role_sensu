# == Class: role_sensu::yaml
#
class role_sensu::yaml (
  $yaml = '
---
role_sensu::rabbitmq::rabbitmq_password:
  secret

role_sensu::server::rabbitmq_password:
  secrettt

role_sensu::server::api_user:
  api_user
  
role_sensu::server::api_password:
  secret
  
role_sensu::dashboard::uchiwa_user:
  ictsupport
  
role_sensu::dashboard::uchiwa_pass:
  ictsupport

role_sensu::dashboard::uchiwa_api_config:
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
    
  check-http_www_nederlandsesoorten_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.nederlandsesoorten.nl/ -q \'Home | Nederlands Soortenregister\'"
    subscribers: "sub-001"

  check-http_www_catalogueoflife_org:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.catalogueoflife.org/ -q \'Welcome to the Catalogue of Life website\'"
    subscribers: "sub-001"

  check-http_www_walvisstrandingen_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.walvisstrandingen.nl/ -q \'Alle geregistreerde Nederlandse walvisstrandingen\'"
    subscribers: "sub-001"
    
  check-http_www_soortenbank_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.soortenbank.nl/ -q \'Zoek naar de soort\'"
    subscribers: "sub-001"
  
  check-http_3d_soortenbank_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://3d.naturalis.nl/ -q \'biodiversity in cyberspace\'"
    subscribers: "sub-001"
    
  check-http_bioportal_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://bioportal.naturalis.nl/ -q \'Browse through Dutch natural history collections\'"
    subscribers: "sub-001"
    
  check-http_www_nationaalherbarium_nl_invasieven:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.nationaalherbarium.nl/invasieven/ -q \'Table of Contents\'"
    subscribers: "sub-001"
    
  check-http_www_nationaalherbarium_nl_FMCollectors:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.nationaalherbarium.nl/FMCollectors/ -q \'Cyclopaedia of\'"
    subscribers: "sub-001"

  check-http_www_nationaalherbarium_nl_Euphorbs:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.nationaalherbarium.nl/Euphorbs/ -q \'Euphorbiaceae\'"
    subscribers: "sub-001"
    
  check-http_www_nationaalherbarium_nl_ThaiEuph:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.nationaalherbarium.nl/ThaiEuph/ -q \'Flora of Thailand\'"
    subscribers: "sub-001"
    
  check-http_iawa_website_org:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://iawa-website.org/ -q \'IAWA: The International Association\'"
    subscribers: "sub-001"
    
  check-http_seedlists_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://seedlists.naturalis.nl/ -q \'Seed lists\'"
    subscribers: "sub-001"
    
  check-http_www_sp2000_org:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://www.sp2000.org/ -q \'Welcome to the Species 2000 website\'"
    subscribers: "sub-001"
    
  check-http_tientjevoortrex_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url http://tientjevoortrex.naturalis.nl/nl/ -q \'De opgraving\'"
    subscribers: "sub-001"
    
  check-http_science_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url https://science.naturalis.nl/en/ -q \'Museum\'"
    subscribers: "sub-001"
    
  check-http_doneren_naturalis_nl:
    command: "/opt/sensu/embedded/bin/ruby /opt/sensu-community-plugins/plugins/http/check-http.rb --url https://doneren.naturalis.nl/Form -q \'Doneren\'"
    subscribers: "sub-001"



') {
  $parameters = parseyaml($role_sensu::yaml::yaml)
  #notice( "$yaml" )
  #notice( "$parameters" ) 
}
