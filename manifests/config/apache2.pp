define ssl::config::apache2 (
    $tls_key      = false,
    $tls_cert     = false,
    $tls_chain    = false,
    $link_to      = false
  ) {

  ssl::config { "apache2_${name}":
    service => 'apache2',
    cert    => $tls_cert,
    key     => $tls_key,
    ca      => false,
    chain   => $tls_chain,
    link_to => $link_to,
    notify  => Service['apache2']
  }

  file_line { "ssl_add_keys_for_${name}":
    path => "${ssl::params::apache_conf}",
    line => "Include ${ssl::params::ssl_root}/services/${name}",
  }

  # if ! $link_to {
  #   ssl::key { "${tls_key}": } ~> Service['apache2']
  #   if $tls_chain { 
  #     ssl::cert { "${tls_ca}": } ~> Service['apache2'] 
  #   }
  #   if $tls_chain { 
  #     ssl::chain { "${tls_chain}": } ~> Service['apache2'] 
  #   }
  # }
}   
