VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  config.vm.box = "bento/ubuntu-18.04"
  config.vm.network "private_network", ip: "192.168.50.53"

  # Update apt packages
  config.vm.provision "shell", name: "apt", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    apt-get update && apt-get upgrade


    # Not all these packages may be required, it is just a list of the most common,
    # plus some for system tests
    packagelist=(
      wget
      unzip
      curl
      libssl-dev
      libreadline-dev
      libyaml-dev
      libxml2-dev
      libxslt1-dev
      libcurl4-openssl-dev
      libnss3
      libx11-dev
      software-properties-common
    )

    apt-get install -y ${packagelist[@]}

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list

    apt-get update
    apt-get install -y google-chrome-stable

  SHELL

  config.vm.provision "shell", name: "install node", inline: <<-'SHELL'

    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    apt-get install -y nodejs

  SHELL

  config.vm.provision "shell", name: "install yarn", inline: <<-'SHELL'

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

    apt update && apt install -y yarn

  SHELL

  config.vm.provision "shell", name: "install apache", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive

    packagelist=(
      apache2
      apache2-dev
      libapr1-dev
      libaprutil1-dev
      libapache2-mod-passenger
    )

    apt-get install -y ${packagelist[@]}

    #Allow port 80 through the firewall
    ufw allow 'Apache'
  SHELL

  config.vm.provision "shell", name: "install sqlite", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive

    packagelist=(
      sqlite3
      libsqlite3-dev
    )

    apt-get install -y ${packagelist[@]}

  SHELL

  config.vm.provision "shell", name: "install ruby", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y ruby-full build-essential
  SHELL

  config.vm.provision "shell", name: "install ruby gems", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    gem install rubyforge rack rake bundler sqlite3 coffee-script webpacker
  SHELL

  config.vm.provision "shell", name: "install rails", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    gem install rails
  SHELL

  config.vm.provision "shell", name: "install phusion passenger", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    # https://www.phusionpassenger.com/library/install/apache/install/oss/bionic/
    gem install passenger
  SHELL

  config.vm.provision "shell", name: "configure apache", inline: <<-'SHELL'
    a2enmod passenger
    a2enmod rewrite

    cp -rp /vagrant/conf/shoppingbasket.conf /etc/apache2/sites-available/

    a2dissite 000-default
    a2ensite shoppingbasket

    apachectl restart

    # Make sure Apache also runs after vagrant reload
    systemctl enable apache2
  SHELL

  config.vm.provision "shell", name: "install required gems", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    # https://www.phusionpassenger.com/library/install/apache/install/oss/bionic/
    cd /vagrant/service && bundler install
  SHELL

  config.vm.provision "shell", name: "install webpacker", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    # https://www.phusionpassenger.com/library/install/apache/install/oss/bionic/
    cd /vagrant/service && rails webpacker:install
  SHELL

  config.vm.provision "shell", name: "create and populate sqlite database", inline: <<-'SHELL'
    export DEBIAN_FRONTEND=noninteractive
    cd /vagrant/service && bin/rake db:drop db:create db:migrate db:seed
  SHELL

  config.vm.post_up_message = <<MESSAGE

    Your Vagrant Server is up and running.

    To access the shopping basket api, please navigate to http://192.168.50.53

    To access the server, you can use 'vagrant ssh'

    On the server, the code is situated in /vagrant/service

MESSAGE

end
