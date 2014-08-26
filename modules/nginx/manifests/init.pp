# Manage nginx webserver
class nginx {
  package { 'nginx':
    ensure => installed,
  }
}
