Vagrant.configure(2) do |config|

  if ENV['DEVBOX_MEMORY']
    memory = ENV["DEVBOX_MEMORY"]
  else
    memory = 1024
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "suviet.devbox"

  config.vm.network "private_network", ip: "192.168.177.71"

  config.vm.provider :virtualbox do |vb|
   vb.name = "vagrant-suviet-devbox"
   vb.memory = memory
  end

  if not(ENV['DEVBOX_BLACKLIST'].include? 'platform')
    config.vm.provision :shell, path: "bash/install-common.sh"
    config.vm.provision :shell, path: "bash/install-nginx.sh"
    config.vm.provision :shell, path: "bash/install-mongodb.sh"
    config.vm.provision :shell, path: "bash/install-redis.sh"

    config.vm.provision :shell, path: "bash/install-nvm.sh", args: "v0.31.1", privileged: false
    config.vm.provision :shell, path: "bash/install-node.sh", args: "v4.4.5", privileged: false
  end

  if not(ENV['DEVBOX_BLACKLIST'].include? 'sulieu')
    config.vm.provision :shell, path: "bash/setup-sulieu.sh", privileged: false
  end

  if (ENV['DEVBOX_WHITELIST'].include? 'modules')
    config.vm.provision :shell, path: "bash/setup-sulieu-modules.sh", privileged: false
  end
end
