#!/usr/bin/env bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/$1/install.sh | bash
echo "source $HOME/.nvm/nvm.sh" >> $HOME/.profile
source $HOME/.profile
