# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.hostname = "mozilla-brasil-webserver"
  config.vm.box = "mozilla-brasil-webserver"
  config.vm.box_url = "http://lab.cynthiapereira.com/mozilla-brasil/mozilla-brasil-webserver_virtualbox.box"

  config.vm.network "private_network", ip: "192.168.33.103"
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "public_network"
  
  config.vm.synced_folder "config", "/vagrant_data"
  config.vm.synced_folder "www", "/srv/www"

  config.vm.provider "virtualbox" do |vb|
	# vb.gui = true
	vb.name = "mozilla-brasil-webserver"
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  
  if defined?(VagrantPlugins::HostsUpdater)
	config.hostsupdater.aliases = ["wp.mozillabrasil.dev"]
	config.hostsupdater.remove_on_suspend = true
  end  
  
  # shell script em bash para desenvolvimento com WordPress
  config.vm.provision :shell, :path => "config/wordpress-provision.sh" 
end
