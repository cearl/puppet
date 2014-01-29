class memcache::install {
    package { "memcached":
      ensure => present,
    }
}

class memcache::pecl-memcached{
    package { "php-pecl-memcached":
      ensure => present,
      require => Class["memcache::install"],
    }
}

class memcache::service{
    service { "memcached":
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      enable => true,
      require => [Class["memcache::install"],Class['memcached::config']],
    }
}

class memcached::config {
    file { "/etc/init.d/memcached":
      mode => 755,
      owner => "root",
      group => "root",
      notify => Service["memcached"],
      content => template("memcache/memcached.erb"),
      }
}

class memcache {
    include memcache::install, memcache::pecl-memcached, memcached::config, memcache::service
}
