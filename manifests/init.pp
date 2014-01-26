class ssl::common (
  $local_cert_install_dir = "puppet_managed"
) {

  include ssl::params
  package { 'openssl': ensure => present }

  if $ssl::params::ca_certificates_pkg {
    package { 'ca-certificates': ensure => present }
  }

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

  if $local_cert_install_dir != "puppet_managed" {
    file { "${ssl::params::ssl_local_certs}/${local_cert_install_dir}" :
      ensure  => directory,
      mode    => '2775',
      recurse => true,
    }
  }

  file { $ssl::params::ssl_private:
    ensure  => directory,
    mode    => '0750',
    purge   => true,
    ignore  => 'ssl-cert-snakeoil.key',
    recurse => true,
  }

  if $ssl::params::install_update_ca {
    file { "update-ca-certificates":
      ensure  => file,
      path    => "${ssl::params::update_ca_path}/update-ca-certificates",
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template("${module_name}/scripts/update-ca-certificates.erb"),
    }

    file { "ca-certificates.conf":
      ensure  => file,
      replace => 'no',
      path    => $ssl::params::ssl_ca_conf,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "",
    }
  }

  exec { 'update-ca-certificates':
    command     => "${ssl::params::update_ca_path}/${ssl::params::update_ca_cmd}",
    refreshonly => true,
    subscribe   => File[$ssl::params::ssl_local_certs]
  }
}
