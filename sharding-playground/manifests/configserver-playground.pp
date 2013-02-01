# -*- mode: ruby -*-

group { "puppet":
        ensure => "present",
}

notify { "Installing Packages!": }

package { "libnss-mdns":
  ensure  => present,
  require => Notify['Installing Packages!']
}

file { "/tmp/mongo_configdb":
	ensure  => directory,
	require => Notify['Installing Packages!']
}


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

exec { "start-cfg":
	command => "/usr/bin/mongod --configsvr --dbpath /tmp/mongo_configdb/ --port 27018 > /tmp/mongocfg.log &",
  path    => "/usr/local/bin/:/bin/",
	require => [ File['/tmp/mongo_configdb'], Package['mongodb-10gen']]
}

exec { "start-mongos":
  command => "/bin/sleep 30 && /usr/bin/mongos --configdb configsrv.local:27018 --port 27019 > /tmp/mongos.log &",
  path    => "/usr/local/bin/:/bin/",
  require => [ Exec['start-cfg'], Package['mongodb-10gen']]
}
