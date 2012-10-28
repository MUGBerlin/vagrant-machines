# MUGBerlin Vagrant definitions

## Purpose

[Vagrant](http://vagrantup.com/) is a nice way to experiment with technologies without polluting your own machine with software.
This is why we use it for experiments in our MongoDB User Group sessions. This repository contains several vagrant definitions for different experiments.

## Preconditions

Please follow the install instructions at http://vagrantup.com/ 

## The machines

### simple-mongo

This is a single node machine, that just starts up a mongo instance and forwards the relevant ports to the host.
It uses a standard Ubuntu base-box and installs mongo via puppet. 

Usage:
``` 
cd simple-mongo
vagrant up
```

You can now:

- connect via mongo client to localhost:27017 (which is the default)
- use vagrant ssh to connect to the virtual machine and then use the mongo client there
- look at the mongo web-interface by connecting to http://localhost:28017

To shut down the vagrant image use:

```
vagrant halt
```

### sharding-playground

This sets up 3 servers with MongoDB connected via a host-only network.

Startup:
```
cd sharding-playground
vagrant up
```

The IP addresses of the 3 servers are

- 10.11.12.13 (server1)
- 10.11.12.14 (server2)
- 10.11.12.15 (server3)

Each server has the same setup. If you want to connect to a certain server via ssh use (e.g. server1):

```
vagrant ssh server1
```

If you want to connect to the MongoDB instances from your host use:

```
mongo 10.11.12.13
```

There is nothing set up for the MongoDB servers. Setting up sharding etc. is aimed to be a group task at our user group meeting.