class ssl::params {
  $ssl_root           = '/etc/ssl'
  $ssl_certs          = "${ssl_root}/certs"
  $ssl_private        = "${ssl_root}/private"
  $ssl_chain          = "${ssl_root}/certs"
  $ssl_local_certs    = '/usr/local/share/ca-certificates'
  $apache_conf		  = '/etc/apache2/httpd.conf'
}
