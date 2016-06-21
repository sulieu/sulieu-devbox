#!/usr/bin/env bash

# install nginx
sudo apt-get update
sudo apt-get -y install nginx
sudo service nginx restart

# configure site
sudo mkdir -p /vagrant/projects
sudo mkdir -p /vagrant/log/nginx
sudo chmod 777 /vagrant/log
sudo tee "/etc/nginx/sites-available/suviet.conf" <<-"EOF"
upstream web_server {
    server 127.0.0.1:7979;
    server 127.0.0.1:7980 backup;
}

server {
    listen 80;
    server_name suviet.devbox 192.168.177.71;
    access_log /vagrant/log/nginx/access.log;
    error_log /vagrant/log/nginx/error.log;
    client_max_body_size 20M;

    location / {
        proxy_set_header HOST $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://web_server;
        proxy_redirect default;
    }
}
EOF
sudo chmod 644 /etc/nginx/sites-available/suviet.conf
sudo rm -f /etc/nginx/sites-enabled/suviet.conf
sudo ln -s /etc/nginx/sites-available/suviet.conf /etc/nginx/sites-enabled/suviet.conf

sudo service nginx stop
sudo update-rc.d nginx disable
sudo tee "/etc/init/nginx.conf" <<-"EOF"
# nginx
description "nginx http daemon"
author "suviet team"

# Listen and start after the vagrant-mounted event
start on vagrant-mounted
stop on runlevel [!2345]

env DAEMON=/usr/sbin/nginx
env PID=/var/run/nginx.pid

expect fork
respawn
respawn limit 10 5

pre-start script
        $DAEMON -t
        if [ $? -ne 0 ]
                then exit $?
        fi
end script

exec $DAEMON
EOF
sudo initctl reload-configuration
sudo initctl list | grep nginx
sudo initctl start nginx
