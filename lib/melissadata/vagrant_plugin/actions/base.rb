module MelissaData::VagrantPlugin::Actions

  class Base
    def initialize(app, env)
      @app = app
      @env = env
    end

    protected

    def copy_file(source_path, dest_subdir='')
      filename = File.basename(source_path)
      sub_dir = dest_subdir.empty? ? filename : "#{dest_subdir}/#{filename}"
      dest_path = File.expand_path(sub_dir, @env['config'].melissadata.target_path)

      if test? "[ -e #{dest_path} ]"
        # file exists
        # sudo "rm -f #{dest_path}"
        @env.ui.info I18n.t("vagrant.plugins.melissadata.file_exists", :filename => dest_path), :prefix => false
      else
        @env.ui.info I18n.t("vagrant.plugins.melissadata.copying_file", :file => filename, :path => dest_path), :prefix => false
        @vm.ssh.upload!(source_path, dest_path)
      end

      sudo "chmod u+w #{dest_path}"
    end

    def copy_dir(source_path, dest_subdir = '.', options={})
      dest_path = File.expand_path(dest_subdir, @env['config'].melissadata.target_path)

      full_dest_path = File.join(dest_path, File.basename(source_path))
      if options[:overwrite]
        exec "rm -rf #{full_dest_path}"
      end

      unless test? "[ -e #{full_dest_path} ]"
        @env.ui.info I18n.t("vagrant.plugins.melissadata.copying_directory", :source => source_path, :target => dest_path), :prefix => false
        @vm.ssh.execute do |ssh|
          scp = Net::SCP.new(ssh.session)
          scp.upload!(source_path, dest_path, :recursive => true)
        end
      end
    end

    def test?(command)
      @vm.ssh.execute do |ssh|
        return ssh.test?(command)
      end
    end

    def exec(command)
      @vm.ssh.execute{ |ssh| ssh.exec! command }
    end

    def sudo(command)
      @vm.ssh.execute{ |ssh| ssh.sudo! command }
    end
  end

end
