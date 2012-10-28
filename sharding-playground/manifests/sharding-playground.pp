# -*- mode: ruby -*-

group { "puppet":
        ensure => "present",
}

notify{"Installing Packages!":}

package{ "mongodb":
        ensure => present,
        require => Notify['Installing Packages!'],
}

service{"mongodb":
        ensure => running,
        require => Package['mongodb'],
}
