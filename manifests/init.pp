class ssl::common (
  $local_cert_install_path = "puppet_managed"
) {

  include ssl::params
  package { 'openssl': ensure => present }

  group { 'ssl-cert':
    ensure => present,
    gid    => 361,
    system => true,
  }

  File {
    require => Package['openssl'],
    group   => 'ssl-cert',
  }


  file { "${ssl::params::ssl_root}/services" :
    ensure  => directory,
    mode    => '0644',
    purge   => true,
  }

  file { $ssl::params::ssl_local_certs:
    ensure  => directory,
    mode    => '2775',
    recurse => true,
  }

  file { "${ssl::params::ssl_local_certs}/puppet_managed" :
    ensure  => directory,
    mode    => '2775',
    purge   => true,
    recurse => true,
  }

  file { "${ssl::params::ssl_local_certs}/${local_cert_install_path}" :
    ensure  => directory,
    mode    => '2775',
    recurse => true,
  }

  file { $ssl::params::ssl_private:
    ensure  => directory,
    mode    => '0750',
    purge   => true,
    ignore  => 'ssl-cert-snakeoil.key',
    recurse => true,
  }

  exec { 'update-ca-certificates':
    command     => '/usr/sbin/update-ca-certificates --fresh',
    refreshonly => true,
    subscribe   => File[$ssl::params::ssl_local_certs]
  }
}
