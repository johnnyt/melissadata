require File.expand_path('lib/melissadata', File.dirname(__FILE__))
MelissaData::VagrantPlugin.load!

Vagrant::Config.run do |config|
  config.vm.box = 'lucid64'
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['chef/cookbooks']
    chef.add_recipe 'melissadata'
  end

  config.vm.forward_port 'melissadata', 1404, 14004
  # config.vm.forward_port 'http', 80, 8888

  # config.melissadata.target_path = '/opt/melissadata'

  # config.vm.customize do |vm|
  #   vm.memory_size = 1024
  #   vm.cpu_count = 2
  # end
end
