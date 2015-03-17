#!/bin/sh
# Run by the Vagrant provisioner is used to allow Puppet Librarian
# to be installed and download the modules before puppet run

# Do an apt-update, install ruby-dev to bootstrap ruby-dev

apt-get update
apt-get install -y ruby-dev git

# Check for librarian-puppet
if hash librarian-puppet >/dev/null; then
    echo "*** librarian-puppet Installed"
else
    echo "*** Install librarian-puppet ***"
    gem install librarian-puppet
fi

# Link the Puppetfile to the global path
if [ ! -L /etc/puppet/Puppetfile ]; then
   ln -s /vagrant/Puppetfile /etc/puppet/Puppetfile
fi

# This will install forge modules to the global modules path.
# ASSUMPTION: "Dice" modules are under active development.
cd /etc/puppet/ && librarian-puppet update
