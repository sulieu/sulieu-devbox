Vagrant.configure(2) do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 7979, host: 7979
  config.vm.network "forwarded_port", guest: 17878, host: 17878

  # config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  config.vm.provision "shell", inline: <<-NODE_EOF
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    sudo apt-get install -y build-essential && \
    sudo apt-get install -y imagemagick && \
    sudo apt-get install -y nodejs && \
    sudo npm install -g pm2 && \
    sudo npm install -g nodemon && \
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
    perl -pi -e 's/#replication:\n/replication:\n  oplogSizeMB: 64\n  replSetName: rs0\n/g' /etc/mongod.conf && \
    sudo service mongod restart && \
    sleep 45 && \
    export LC_ALL=C && \
    mongo --eval "rs.initiate()" && \
    mongo --eval "rs.conf()" && \
    mongo --eval "rs.status()";
  MONGO_EOF

  config.vm.provision "shell", inline: <<-SULIEU_EOF
    sudo apt-get install -y git && \
    cd /vagrant && \
    [ ! -d "sulieu-web" ] && git clone https://github.com/sulieu/sulieu-web.git && \
    cd sulieu-web && \
    git submodule update --init --recursive && \
    export LC_ALL=C && \
    mongo suviet-timeline --eval "db.dropDatabase()" && \
    mongo suviet-skywall --eval "db.dropDatabase()" && \
    mongorestore -d suviet-timeline ./data/mongodata/suviet-timeline && \
    mongorestore -d suviet-skywall  ./data/mongodata/suviet-skywall && \
    echo -e "\nexport NODE_DEVEBOT_PROFILE=console" | tee -a "/home/vagrant/.bashrc" && \
    echo -e "\nexport NODE_DEVEBOT_SANDBOX=demo" | tee -a "/home/vagrant/.bashrc"
  SULIEU_EOF
end
