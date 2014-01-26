class ssl::params {
  
  $apache_conf		  = '/etc/apache2/httpd.conf'

  case $::osfamily {
    'AIX': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/ca-certificates.conf'
      $ssl_system_certs   = '/usr/share/ca-certificates'
      $ssl_local_certs    = '/usr/local/share/ca-certificates'
      $ssl_layout_style   = 'Debian'
      $ca_certificate_pkg = false
      $install_update_ca  = true
      $update_ca_path     = '/usr/sbin'
      $update_ca_cmd      = 'update-ca-certificates --fresh'
    }
    'Debian': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/ca-certificates.conf'
      $ssl_system_certs   = '/usr/share/ca-certificates'
      $ssl_local_certs    = '/usr/local/share/ca-certificates'
      $ssl_layout_style   = 'Debian'
      $ca_certificate_pkg = true
      $install_update_ca  = false
      $update_ca_path     = '/usr/sbin'
      $update_ca_cmd      = 'update-ca-certificates --fresh'
    }
    'RedHat': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/pki/default.cfg'
      $ssl_system_certs   = '/etc/pki/ca-trust/source/anchors'
      $ssl_local_certs    = '/etc/pki/ca-trust/source/anchors'
      $ssl_layout_style   = 'RedHat'
      $ca_certificate_pkg = true
      $install_update_ca  = false
      $update_ca_path     = '/usr/bin'
      $update_ca_cmd      = 'update-ca-trust extract'
    }
    'SuSE': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/ca-certificates.conf'
      $ssl_system_certs   = '/usr/share/ca-certificates'
      $ssl_local_certs    = '/usr/local/share/ca-certificates'
      $ssl_layout_style   = 'Debian'
      $ca_certificate_pkg = true
      $install_update_ca  = true
      $update_ca_path     = '/usr/sbin'
      $update_ca_cmd      = 'update-ca-certificates --fresh'
    }
    'FreeBSD': {
      
    }
    'Archlinux': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/ca-certificates.conf'
      $ssl_system_certs   = '/usr/share/ca-certificates'
      $ssl_local_certs    = '/usr/local/share/ca-certificates'
      $ssl_layout_style   = 'Debian'
      $ca_certificate_pkg = true
      $install_update_ca  = false
      $update_ca_path     = '/usr/bin'
      $update_ca_cmd      = 'update-ca-certificates --fresh'
    }
    # Gentoo was added as its own $::osfamily in Facter 1.7.0
    'Gentoo': {
      $ssl_root           = '/etc/ssl'
      $ssl_certs          = "${ssl_root}/certs"
      $ssl_private        = "${ssl_root}/private"
      $ssl_chain          = "${ssl_root}/certs"
      $ssl_ca_conf        = '/etc/ca-certificates.conf'
      $ssl_system_certs   = '/usr/share/ca-certificates'
      $ssl_local_certs    = '/usr/local/share/ca-certificates'
      $ssl_layout_style   = 'Debian'
      $ca_certificate_pkg = true
      $install_update_ca  = false
      $update_ca_path     = '/usr/sbin'
      $update_ca_cmd      = 'update-ca-certificates --fresh'
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      # Before Facter 1.7.0 Gentoo did not have its own $::osfamily
      case $::operatingsystem {
        'Gentoo': {
          $ssl_root           = '/etc/ssl'
          $ssl_certs          = "${ssl_root}/certs"
          $ssl_private        = "${ssl_root}/private"
          $ssl_chain          = "${ssl_root}/certs"
          $ssl_ca_conf        = '/etc/ca-certificates.conf'
          $ssl_system_certs   = '/usr/share/ca-certificates'
          $ssl_local_certs    = '/usr/local/share/ca-certificates'
          $ssl_layout_style   = 'Debian'
          $ca_certificate_pkg = true
          $install_update_ca  = false
          $update_ca_path     = '/usr/sbin'
          $update_ca_cmd      = 'update-ca-certificates --fresh'
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
