#!/usr/bin/env bash

mkdir -p /vagrant/projects/sulieu-web/node_modules && \
cd /vagrant/projects/sulieu-web/node_modules && \
rm -rf app-timeline && \
git clone https://github.com/apporo/app-timeline.git && \
cd app-timeline && \
npm install
