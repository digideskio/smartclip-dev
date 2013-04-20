class apache2::config inherits apache2::params {
  $www_user = 'www-data'
  $iptables_hosts = $apache2::params::iptables_hosts
  $apache_port = $apache2::params::apache_port
  
  Exec {
    path      => "${::path}",
    logoutput => on_failure,
  }
  # iptables
  file { '/tmp/.arcus.iptables.rules.apache2':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0600,
    content => template('apache2/iptables.erb'),
  }

  file { '/etc/apache2/apache2.conf':
    ensure => present,
    owner => root,
    group => root,
    mode => 0644,
    content => template('apache2/apache2.conf.erb'),
    require => [ Package['apache2'], Package['libapache2-mod-wsgi'] ],    
    notify => Service['apache2']
  }
  
  file { '/etc/apache2/conf.d/smartclip.conf':
    ensure => present,
    owner => root,
    group => root,
    mode => 0644,
    content => template('apache2/smartclip.conf.erb'),
    require => [ Package['apache2'], Package['libapache2-mod-wsgi'] ],
    notify => Service['apache2']
  }
}
