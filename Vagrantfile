# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 7979, host: 7979
  config.vm.network "forwarded_port", guest: 17878, host: 17878

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  config.vm.provision "shell", inline: <<-NODE_EOF
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    sudo apt-get install -y build-essential && \
    sudo apt-get install -y imagemagick && \
    sudo apt-get install -y nodejs && \
    sudo npm install -g pm2 && \
    sudo npm install -g node-gyp && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/*;
  NODE_EOF

  config.vm.provision "shell", inline: <<-REDIS_EOF
    sudo apt-get install -y build-essential && \
    cd /tmp && \
    wget http://download.redis.io/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    sudo make install && \
    cd utils && \
    echo -n | sudo ./install_server.sh && \
    cd /tmp && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/*;
  REDIS_EOF

  config.vm.provision "shell", inline: <<-MONGO_EOF
    sudo apt-get install -y build-essential && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    sudo apt-get update && \
    sudo apt-get install -y mongodb-org && \
    sudo apt-get clean;
    sudo service mongod restart && \
    sleep 10 && \
    perl -pi -e 's/bindIp: 127.0.0.1/#bind_ip=127.0.0.1/g' /etc/mongod.conf && \
    echo -e "replication:\n  oplogSizeMB: 64\n  replSetName: rs0\n" | tee -a "/etc/mongod.conf" && \
    sudo service mongod restart && \
    sleep 30 && \
    export LC_ALL=C && \
    LC_ALL=C mongo --eval "rs.initiate()" && \
    LC_ALL=C mongo --eval "rs.conf()" && \
    LC_ALL=C mongo --eval "rs.status()";
  MONGO_EOF

  config.vm.provision "shell", inline: <<-SULIEU_EOF
    sudo apt-get install -y git && \
    cd /vagrant && \
    git clone https://github.com/sulieu/sulieu-web.git && \
    cd sulieu-web && \
    git submodule update --init --recursive && \
    export LC_ALL=C && \
    LC_ALL=C mongo suviet-timeline --eval "db.dropDatabase()" && \
    LC_ALL=C mongo suviet-skywall --eval "db.dropDatabase()" && \
    LC_ALL=C mongorestore -d suviet-timeline ./data/mongodata/suviet-timeline && \
    LC_ALL=C mongorestore -d suviet-skywall  ./data/mongodata/suviet-skywall && \
    echo -e "\nexport NODE_DEVEBOT_PROFILE=console" | tee -a "/home/vagrant/.bashrc" && \
    echo -e "\nexport NODE_DEVEBOT_SANDBOX=demo" | tee -a "/home/vagrant/.bashrc" && \
    npm install
  SULIEU_EOF
end
