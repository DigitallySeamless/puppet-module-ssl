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

  case $ssl::params::ssl_layout_style {
    "RedHat": {
      $file_path = "${ssl::params::ssl_local_certs}/${prefix}${name}.crt"
    }
    default, "Debian": {
      $file_path = "${ssl::params::ssl_local_certs}/${local_cert_install_dir}/${prefix}${name}.crt"
    }
  }

  file { "${file_path}" :
    ensure  => file,
    mode    => '0444',
    group   => 'ssl-cert',
    source  => $source,
    require => Package['openssl'],
    notify  => Exec['update-ca-certificates'],
  }
}
