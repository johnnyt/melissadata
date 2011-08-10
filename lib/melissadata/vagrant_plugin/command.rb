module MelissaData
  module VagrantPlugin

    class Command < ::Vagrant::Command::GroupBase
      register "md", "MelissaData stuff"
      # Examples:
      # DQ-DVD-2011-05
      # GEO-DVD-2011-Q2

      # source_root Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-.\d$/ }
      # def self.source_root
      #   @source_root ||= Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-.\d$/ }
      # end

      desc "install", "Install MelissaData gem on the vagrant box"
      def install
        target_vms.each do |vm|
          vm.env.actions.run(:md_install, 'melissadata.source_path' => 'foo')
        end
      end

      # protected

      # def execute_on_vm(vm)
      #   # vm.env.actions.run(:melissadata, 'melissadata.source_root' => self.class.source_root)
      #   vm.env.actions.run(:melissadata, 'melissadata.source_path' => 'foo')
      # end
    end

  end
end
