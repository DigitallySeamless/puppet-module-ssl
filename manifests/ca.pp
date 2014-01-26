define ssl::ca (
  $source = "puppet:///files/ssl/${name}.crt",
  $local_cert_install_dir = "puppet_managed",
) {
  include ssl::params
  class { '::ssl::common' :
    local_cert_install_dir => $local_cert_install_dir,
  }

  if $local_cert_install_dir == 'puppet_managed' {
    $prefix = "ca_"
  }
  else {
    $prefix = ""
  }

  file { "${ssl::params::ssl_local_certs}/${local_cert_install_dir}/${prefix}${name}.crt" :
    ensure  => file,
    mode    => '0444',
    group   => 'ssl-cert',
    source  => $source,
    require => Package['openssl'],
    notify  => Exec['update-ca-certificates'],
  }
}
