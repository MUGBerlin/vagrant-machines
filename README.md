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
 