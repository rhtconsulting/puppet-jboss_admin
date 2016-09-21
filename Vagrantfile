# -*- mode: ruby -*-
# vi: set ft=ruby :

# install required plugins
#
# sources:
#   http://www.unknownerror.org/opensource/mitchellh/vagrant/q/stackoverflow/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
#   http://matthewcooper.net/2015/01/15/automatically-installing-vagrant-plugin-dependencies/
required_plugins  = ['r10k', 'vagrant-r10k']
plugins_installed = false
required_plugins.each do |plugin|
  if ! Vagrant.has_plugin? plugin
    system("vagrant plugin install #{plugin}")
    plugins_installed = true
  end
end

# test that puppet is installed as a Vagrant plugin
# you can't use ``Vagrant.has_plugin?("puppet")`` because Vagrant's built-in
# Puppet Provisioner provides a plugin named "puppet", so this always evaluates to true.
# 
# source: https://github.com/jantman/vagrant-r10k
#begin
#  gem "puppet"
#rescue Gem::LoadError
#  system("vagrant plugin install puppet")
#  plugins_installed = true
#end

# if any plugins installed, restart the Vagrant process
if plugins_installed
  exec "vagrant #{ARGV.join(' ')}"
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # Puppet labs CentOS box with Puppet 3.7
  config.vm.box         = "puppetlabs/centos-6.6-64-puppet"
  config.vm.box_version = '1.0.1'

  # NOTE: use username/password to log into box since SSH keys can be unreliable on different platforms.
  config.ssh.username = "vagrant"
  config.ssh.insert_key = false
  #config.ssh.password = "vagrant"

  # sync the jboss_admin module to the Vagrant box for testing
  config.vm.synced_folder ".", "/modules/jboss_admin"

  # sync the modules from the Puppetfile
  config.vm.synced_folder "./vagrant/modules", "/modules/"

  # if JBOSS_EAP environment variable is set copy JBoss EAP ZIP to the box and then use puppet to install and start it.
  # else use Puppet to download, install, and start WildFly
  manifest_file = nil
  if ENV['JBOSS_EAP']
    config.vm.provision 'file', source: ENV['JBOSS_EAP'], destination: '/var/tmp/jboss-eap.zip'
    manifest_file     = 'jboss_eap.pp'
  else
    manifest_file = 'wildfly.pp'
  end

  # r10k plugin to deploy the needed community puppet modules
  config.r10k.puppet_dir      = 'vagrant'
  config.r10k.puppetfile_path = 'vagrant/Puppetfile'

  # Use Puppet to install and start WildFly or JBoss EAP
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'vagrant/manifests'
    puppet.manifest_file  = manifest_file
    puppet.module_path    = 'vagrant/modules'
  end
end
