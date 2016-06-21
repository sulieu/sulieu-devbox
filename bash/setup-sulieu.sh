#!/usr/bin/env bash

mkdir -p /vagrant/projects && \
cd /vagrant/projects && \
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
