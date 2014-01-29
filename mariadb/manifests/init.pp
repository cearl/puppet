class mariadb::repo {
  file { "/etc/yum.repos.d/MariaDB.repo":
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => 644,
    source => "puppet:///modules/mariadb/mariadb.repo",
    recurse => true,
  }
}

class mariadb::install {
  package { 'MariaDB-server' :
    ensure => latest,
    require => Class['mariadb::repo'],
  }
}
class mariadb::service {
  service { "mysql":
    ensure => "running",
    require => Class['mariadb::config'],
  }
}

class mariadb::config{
  file { "/etc/my.cnf":
    owner => 'root',
    group => 'root',
    mode => 644,
    content => template("mariadb/my.cnf.erb"),
    ensure => present,
    require => [Class['mariadb::repo'],Class['mariadb::install']],
    
  }
}

class mariadb::client {
  package { 'MariaDB-client':
    ensure => latest,
    require => Class['mariadb::repo'],  
  }
}

class mariadb {
  include mariadb::repo, mariadb::install,mariadb::config,mariadb::client,mariadb::service
  }
