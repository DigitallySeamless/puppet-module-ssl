#This should not be called directly. Use service specific defines instead.
#The cert name is the name of the resource
define ssl::config (
  $service,
  $key,
  $cert,
  $ca       = false,
  $chain    = false,
  $link_to  = false
  ) {
  include ssl::params
  include ssl::common

  if ! $key and ! $link_to {
    fail( 'You must pass either $key or $link_to')
  }

  if $link_to {
    file { "${ssl::params::ssl_root}/services/${name}":
      ensure  => link,
      target  => "${ssl::params::ssl_root}/services/${service}_${link_to}",
    }
  }
  else {
    ssl::cert { "${cert}": } 

    if $key { 
      ssl::key { "${key}": }
    }
    if $ca { 
      ssl::ca { "${ca}": }
    }
    if $chain { 
      ssl::chain { "${chain}": }
    }

    file { "${ssl::params::ssl_root}/services/${name}" :
      ensure  => file,
      mode    => '0644',
      content => template("ssl/services/${service}_ssl.erb"),
    }
  }
}

