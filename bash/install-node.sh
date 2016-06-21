#!/usr/bin/env bash

source $HOME/.nvm/nvm.sh

nvm install $1
nvm alias default $1

npm install -g grunt-cli
npm install -g gulp-cli
npm install -g bower
npm install -g webpack
npm install -g pm2
npm install -g nodemon
npm install -g node-gyp
