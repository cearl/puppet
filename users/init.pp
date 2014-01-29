define users::create (
  $comment = "Employee",
  $groups,
  $password,
  $pubkey = '',
  $pubkeytype = "ssh-rsa",
  $shell = "/bin/bash",
    
) {

      user { "${name}":
        comment => "$comment",
        home => "/home/${name}",
        managehome => true,
        groups => "$groups",
        shell => "$shell",
        password => "$password",
        password_max_age => "90",
        provider => 'useradd',
        ensure => present,
      }

      file {"/home/${name}/.ssh":
        ensure  => directory,
        owner   => "${name}",
        group   => "${name}",
        mode    => 600,
      }

      if ($pubkey !='') {
        ssh_authorized_key { "${name}":
                ensure   => present,
                name     => "${name}",
                key      => "$pubkey",
                type     => "$pubkeytype",
                user     => "${name}",
        }
      }

}
