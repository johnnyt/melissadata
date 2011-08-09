# require './lib/melissadata/vagrant-melissadata'
require File.expand_path('lib/melissadata/melissadata', File.dirname(__FILE__))
MelissaData::VagrantPlugin
# require './lib/vagrant-rake/lib/vagrant-rake'
# require './lib/vagrant-mysql/lib/vagrant-mysql'

Vagrant::Config.run do |config|
  config.vm.box = 'lucid64'
  # config.vm.forward_port 'http', 80, 8888
  # config.vm.forward_port 'melissa_data', 23456, 23457

  config.melissadata.target_path = '/opt/melissadata'
  # config.melissadata.source_path = '/Volumes/'

  config.vm.customize do |vm|
    vm.memory_size = 1024
    vm.cpu_count = 2
  end

  config.vm.provision :chef_solo do |chef|
    chef.roles_path = 'chef/roles'
    chef.cookbooks_path = ['chef/cookbooks']
    chef.add_role 'vagrant'
    # chef.add_recipe 'melissa_data'
  end
end
