class apache2::package {
  Exec {
    path      => "${::path}",
    logoutput => on_failure,
  }
  if ! defined(Package['apache2']) {
    package { 'apache2':
      ensure  => installed,
    }
  }

  if ! defined(Package['libapache2-mod-wsgi']) {
    package { 'libapache2-mod-wsgi':
      ensure => installed,
      require => Package['apache2']
    }
  }
}
