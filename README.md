# sulieu-misc

> Miscellaneous utilities for sulieu-web, include Vagrantfile.

## Vagrantfile

Use vagrant to set up local development environment for sulieu-web application.

### Windows

Reproduce local Linux environment for sulieu-web with the following:

#### Install VirtualBox

1. Download the most recent VirtualBox for Windows from https://www.virtualbox.org/wiki/Downloads.
2. Run VirtualBox installer and follow the on-screen instructions.

#### Install Vagrant

Download and install the latest version of Vagrant from https://www.vagrantup.com/downloads.html.

#### Install PuTTY

In order to log in to the server and perform additional provision, such as setting the configured IP, port forwarding, folder shares, VirtualBox Guest Additions,... all base boxes are required to have the Vagrant public key already installed, along with a user named “vagrant”, with password-less sudo privileges.

When we use Windows as host, we face a problem is that Windows doesn’t come with an SSH command line client. This means the built-in SSH functions of Vagrant won’t necessarily work for us Windows users. To pass this issue, we should configure PuTTY to work as Vagrant SSH client.

Get a copy of PuTTY from [here](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html).

To get Vagrant box SSH information, type the command:

```shell
$ vagrant ssh-config
```

The result includes IP, port and some other information. Open PuTTY, enter the IP and port, give the connection a name, and save it. You can now connect to the box over SSH with PuTTY. The username and password are both “vagrant” without the quotation marks.
