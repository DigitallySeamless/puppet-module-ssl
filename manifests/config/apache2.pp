define ssl::config::apache2 (
    $tls_key    = false,
    $tls_ca     = false,
    $tls_chain  = false,
    $link_to    = false
  ) {

  ssl::config { "apache2_${name}":
    service => 'apache2',
    cert    => $name,
    key     => $tls_key,
    ca      => $tls_ca,
    chain   => $tls_chain,
    link_to => $link_to,
    notify  => Service['apache2']
  }

  if ! $link_to {
    ssl::key[$tls_key]                      ~> Service['apache2']
    ssl::cert[$name]                        ~> Service['apache2']
    if $tls_ca    { ssl::cert[$tls_ca]      ~> Service['apache2'] }
    if $tls_chain { ssl::chain[$tls_chain]  ~> Service['apache2'] }
  }
}
