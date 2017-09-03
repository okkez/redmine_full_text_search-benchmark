# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  name = "redmine-local"
  config.vm.define(name) do |node|
    node.vm.box = "debian/stretch64"
    node.vm.network "private_network", ip: "192.168.33.50"
    node.vm.provider :virtualbox do |virtual_box|
      virtual_box.memory = 2048
    end
    node.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "servers" => [name],
      }
      ansible.host_key_checking = false
    end
  end

  name = "fluentd"
  config.vm.define(name) do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.network "private_network", ip: "192.168.33.51"
    node.vm.provider :virtualbox do |virtual_box|
      virtual_box.memory = 2048
    end
    node.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/playbook.yml"
      ansible.groups = {
        "fluentd" => [name],
      }
      ansible.host_key_checking = false
    end
  end
end
