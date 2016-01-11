# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 5000, host: 5000 # Web server
  config.vm.network "forwarded_port", guest: 5900, host: 5900 # VNC
  config.vm.synced_folder ".", "/home/vagrant/blink"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    sudo apt-get update && \
    sudo apt-get install -y htop tmux libmagickwand-dev libpq-dev imagemagick nodejs postgresql postgresql-contrib unzip google-chrome-stable xvfb x11vnc && \
    cd /tmp && \
    wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz && \
    tar -xzvf ruby-install-0.6.0.tar.gz && \
    cd ruby-install-0.6.0/ && \
    sudo make install && \
    sudo ruby-install --system --latest ruby && \
    sudo gem install bundler

    latest=`curl http://chromedriver.storage.googleapis.com/LATEST_RELEASE`
    download_location="http://chromedriver.storage.googleapis.com/$latest/chromedriver_linux64.zip"
    cd /tmp
    rm /tmp/chromedriver_linux64.zip
    wget -P /tmp $download_location
    unzip /tmp/chromedriver_linux64.zip -d .
    sudo mv ./chromedriver /usr/local/bin/
    sudo chmod a+x /usr/local/bin/chromedriver

    # Postgres setup is manual.
    # sudo -i -u postgres
    # createuser --interactive (create user with name vagrant)
  SHELL
end
