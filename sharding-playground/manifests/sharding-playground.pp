# -*- mode: ruby -*-

group { "puppet":
  ensure => "present",
}

notify { "Installing Packages!": }

file {"/etc/apt/sources.list.d/10gen.list":
  ensure  => "present",
  source  => "/vagrant/manifests/10gen.list",
  require => Notify['Installing Packages!'],
}

exec { "add-10genkey":
  command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && /usr/bin/apt-get update",
  path    => "/usr/local/bin/:/bin/:/usr/bin/",
  require => File['/etc/apt/sources.list.d/10gen.list'],
}

package { "mongodb-10gen":
        ensure => present,
        require => Exec['add-10genkey'],
}

file { "/etc/mongodb.conf":
  ensure  => "present",
  source  => "/vagrant/manifests/mongodb.conf",
  require => Package['mongodb-10gen'],
}

package { "libnss-mdns":
  ensure  => present,
  require => Notify['Installing Packages!']
}

service{"mongodb":
        ensure => running,
        subscribe => File['/etc/mongodb.conf'],
}
