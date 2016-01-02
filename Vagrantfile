# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 5000, host: 5000 # Web server
  config.vm.synced_folder ".", "/home/vagrant/blink"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && \
    sudo apt-get install -y libmagickwand-dev libpq-dev imagemagick nodejs postgresql postgresql-contrib && \
    cd /tmp && \
    wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz && \
    tar -xzvf ruby-install-0.6.0.tar.gz && \
    cd ruby-install-0.6.0/ && \
    sudo make install && \
    sudo ruby-install --system --latest ruby && \
    sudo gem install bundler

    # Postgres setup is manual.
    # sudo -i -u postgres
    # createuser --interactive (create user with name vagrant)
  SHELL
end
