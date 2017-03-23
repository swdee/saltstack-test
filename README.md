# saltstack-test

Basic test of Salt



# Overview

This test demonstrates configuration of Salt using a VM with Linode consisting
of the salt master and minon running on the same VM.  It is configured to deploy a
logger script to run periodically from a cronjob with output appended to log file.
It also creates local accounts accessible by provided SSH key.



# Preparation

1. Create a Linode 1024 instance with Linode. Deploy using "Ubuntu 16.10" 
image and set root password.  Obtain IP address details from "Remote Access" tab
once instance has booted.


2. SSH into the VM and install Saltstack Ubuntu PPA repository using the following commands.

```sh
$ sudo apt install software-properties-common
$ sudo add-apt-repository ppa:saltstack/salt
```

3. Once the PPA has been added install the Salt Master and Minion 

```sh
$ sudo apt-get install salt-master salt-minion 
```



# Check out Salt config files used in this test

```sh
$ sudo git clone https://github.com/swdee/saltstack-test /srv
```


# Configure Salt Master

1. Edit the master config file in your favourite text editor

```sh
$ sudo nano /etc/salt/master
```

2. Set the file_roots config parameter to point to the base directories created above
so it looks like the following. (This can
be done by uncommenting the default example in the config file).

```
file_roots:
  base:
    - /srv/salt
    - /srv/formulas
```

3. Set the pillar_roots config parameter to look like the following. (This can
be done by uncommenting the default example in the config file).

```
pillar_roots:
  base:
    - /srv/pillar
```

4. Save changes and exit editor.



# Configure Minion

1. Edit Minion config file.

```sh
$ sudo nano /etc/salt/minion
```

2. Set the master parameter for this minion to connect to the master on the
local loopback.  The config change will look like the following.

```
master: 127.0.0.1
```

3. Save changes and exit editor.



# Start Salt and Setup Keys

1. Start Salt Master and Minion daemons.

```sh
$ sudo service salt-master restart
$ sudo service salt-minion restart
```

2.  Upon service restart the Minion has connected to the Master, now we need to
accept is key to establish communication between them.  List all keys using the 
following command.

```sh
$ sudo salt-key --list all
```


This will output the list of keys including our new Minion which is identified
under the "Unaccepted Keys" section by its hostname, in this case
"ubuntu.members.linode.com".

```
Accepted Keys:
Denied Keys:
Unaccepted Keys:
ubuntu.members.linode.com
Rejected Keys:
```


NOTE: In this example as Master and Minion are running on the same host doing
a key check to verify authorised keys has been skipped.  When Minion is running on
a different host a best practice is to check keys before accepting to ensure only 
authorised Minions are added to the Master.


3. Accept Minion key using the following command and by passing its hostname 
as parameter (in this case "ubuntu.members.linode.com").

```sh
$ sudo salt-key -a ubuntu.members.linode.com
```


4. Do a simple test to verify communications between Master and Minion.

```sh
$ sudo salt '*' test.ping
```


This will output the hostname and value of "True" to indicate the check 
was successful.

```
ubuntu.members.linode.com:
    True
```


Basic setup of Master and Minion is now complete.



# Apply Salt States

1. Using the salt state configuration files checked out by git above, apply them

```sh
salt ubuntu.members.linode.com state.apply logger
salt ubuntu.members.linode.com state.apply addusers
```


# Connection testing

From your local workstation using the provided SSH keys connect to one of the 
deployed users

```sh
@workstation$ ssh -i salt-demo-keys user1@23.239.0.14
```

View contents of logger counts file

```sh
$ sudo cat /root/counts.log
```

