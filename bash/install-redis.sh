#!/usr/bin/env bash

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
