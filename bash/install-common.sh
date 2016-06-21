#!/usr/bin/env bash

sudo apt-get install -y build-essential
sudo apt-get install -y git
sudo apt-get install -y imagemagick
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/* /tmp/*
