# -*- mode: ruby -*-

package { 'vim':
	ensure => present,
}

group { 'puppet':
	ensure => 'present',
}

package { 'libnss-mdns':
	ensure  => present,
}

file { '/etc/apt/sources.list.d/10gen.list':
  	ensure  => 'present',
  	source  => '/vagrant/manifests/10gen.list',
}

exec { 'add-10genkey':
  	command => '/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && /usr/bin/apt-get update',
  	path    => '/usr/local/bin/:/bin/:/usr/bin/',
  	require => File['/etc/apt/sources.list.d/10gen.list'],
}

package { 'mongodb-10gen':
  	ensure  => present,
  	require => Exec['add-10genkey'],
}

file { '/etc/mongodb.conf':
  	ensure  => present,
  	source  => '/vagrant/manifests/mongodb.conf',
  	require => Package['mongodb-10gen'],
}

service{ 'mongodb':
    ensure => running,
    subscribe => File['/etc/mongodb.conf'],
}
