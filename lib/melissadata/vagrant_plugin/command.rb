module MelissaData::VagrantPlugin

  class Command < ::Vagrant::Command::GroupBase
    register "md", "MelissaData vagrant commands"

    desc "install", "Install MelissaData gem on the vagrant box"
    def install
      target_vms.each do |vm|
        vm.env.actions.run(:md_install)
      end
    end

    desc "update", "Update the MelissaData gem on the vagrant box"
    def update
      target_vms.each do |vm|
        vm.env.actions.run(:md_update)
      end
    end

    desc "upload", "Upload the new data files to CloudFiles"
    def upload
      target_vms.each do |vm|
        vm.env.actions.run(:md_upload)
      end
    end
  end

end
