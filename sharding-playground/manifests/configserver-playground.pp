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

package{ "libnss-mdns":
        ensure => present,
        require => Notify['Installing Packages!']
}

file { "/tmp/mongo_configdb":
	ensure => directory,
	require => Notify['Installing Packages!']
}

exec { "start-cfg":
	command => "/usr/bin/mongod --configsvr --dbpath /tmp/mongo_configdb/ --port 27018 &",
    	path    => "/usr/local/bin/:/bin/",
	require => [ File['/tmp/mongo_configdb'], Package['mongodb']]
}

exec { "start-mongos":
        command => "/usr/bin/mongos --configdb shard04.local:27018 --port 27019 &",
        path    => "/usr/local/bin/:/bin/",
        require => [ Exec['start-cfg'], Package['mongodb']]
}
