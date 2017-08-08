# This guide is optimized for Vagrant 1.7 and above.
# Although versions 1.6.x should behave very similarly, it is recommended
# to upgrade instead of disabling the requirement below.

# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrant.require_version ">= 1.7.0"

SERVER_SCRIPT = <<EOF.freeze
echo "Preparing server..."

# ensure the time is up to date
apt-get update
apt-get -y install ntp ntpdate apt-transport-https
service ntp stop
ntpdate -s pool.ntp.br
service ntp start
echo "10.1.1.33 claudinha-ci.local" | tee -a /etc/hosts
EOF

def set_hostname(server)
  server.vm.provision 'shell', inline: "hostname #{server.vm.hostname}"
end

Vagrant.configure(2) do |config|
  config.vm.define 'concourse-server' do |cs|
    cs.vm.box = 'debian/jessie64'
    cs.vm.hostname = 'claudinha-ci.local'
    cs.vm.network 'private_network', ip: '10.1.1.33'
    # cs.vm.provision 'shell', inline: SERVER_SCRIPT.dup
    set_hostname(cs)

    cs.vm.provider 'virtualbox' do |v|
      v.memory = 1024
      v.cpus = 2
    end

    # Disable the new default behavior introduced in Vagrant 1.7, to
    # ensure that all Vagrant machines will use the same SSH key pair.
    # See https://github.com/mitchellh/vagrant/issues/5005
    config.ssh.insert_key = false

    config.vm.provision "ansible" do |ansible|
      ansible.verbose = "vv"
      ansible.playbook = "playbook.yml"
    end
  end
end