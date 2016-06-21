#!/usr/bin/env bash

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
