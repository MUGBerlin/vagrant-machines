# -*- mode: ruby -*-

group { "puppet":
        ensure => "present",
}

notify{"Installing Packages!":}

package{ "mongodb":
        ensure => present,
        require => Notify['Installing Packages!'],
}

file{"/etc/mongodb.conf":
  ensure => "present",
  source => "/vagrant/manifests/mongodb.conf",
  require => Package['mongodb'],
}

service{"mongodb":
        ensure => running,
        subscribe => File['/etc/mongodb.conf'],
}

package{ "libnss-mdns":
        ensure => present,
        require => Notify['Installing Packages!']
}
