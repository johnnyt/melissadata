Vagrant::Config.run do |config|
  config.vm.box = 'melissa_data'
  config.vm.forward_port 'http', 80, 8888
  config.vm.forward_port 'melissa_data', 23456, 23457

  config.vm.customize do |vm|
    vm.memory_size = 1024
    vm.cpu_count = 2
  end

  # config.vm.provision :chef_solo do |chef|
  #   chef.roles_path = '../aha_roles'
  #   chef.cookbooks_path = ['../aha_cookbooks']
  #   chef.add_role 'vagrant'
  #   chef.add_recipe 'melissa_data'
  # end
end
