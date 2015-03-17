# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "solrcloud" do |solrcloud|
    solrcloud.vm.box = "ubuntu/trusty64" #Needed a newer OS
    solrcloud.vm.network :forwarded_port, guest: 8983, host: 1234
    solrcloud.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    solrcloud.vm.provision "shell", path: "shell/bootstrap.sh"
    solrcloud.vm.provision :puppet do |puppet|
      puppet.manifests_path = "vagrant"
      puppet.manifest_file  = "base.pp"
      puppet.module_path = [ 'modules/', 'others/' ]
      puppet.options = "--verbose --debug"
    end
  end
end
