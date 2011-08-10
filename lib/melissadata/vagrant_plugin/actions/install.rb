module MelissaData
  module VagrantPlugin
    module Actions

      # A Vagrant middleware which installs the gem on the VM
      class Install
        def initialize(app, env)
          @app = app
          @env = env
        end

        def call(env)
          @vm = env['vm']
          if @vm.created? && @vm.vm.running?
            target_root = env['config'].melissadata.target_path
            env.ui.info I18n.t("vagrant.plugins.melissadata.installing", :path => target_root), :prefix => false

            sudo "mkdir -p #{target_root}/lib #{target_root}/src && chown -R vagrant:vagrant #{target_root}"

            source_paths_and_names.each do |source_path,name|
              Dir["#{source_path}/linux/gcc34_64bit/*.h"].each{ |filename| copy_file filename, 'src' }
              copy_file "#{source_path}/linux/gcc34_64bit/libmd#{name}.so", 'lib'
              copy_file "#{source_path}/linux/interfaces/ruby/md#{name}RubyWrapper.cpp", 'src'
            end

            copy_file File.expand_path("templates/Makefile", MelissaData.gem_root), 'src'

            env.ui.info I18n.t("vagrant.plugins.melissadata.compiling"), :prefix => false
            sudo "cd #{target_root}/src && make"
          else
            env.ui.error "Vagrant VM is not running", :prefix => false
          end

          @app.call(env)
        end

        protected

        def sudo(command)
          @vm.ssh.execute{ |ssh| ssh.sudo! command }
        end

        def copy_file(source_path, dest_subdir)
          filename = File.basename(source_path)
          dest_path = File.expand_path("#{dest_subdir}/#{filename}", @env['config'].melissadata.target_path)

          @env.ui.info I18n.t("vagrant.plugins.melissadata.copying_file", :file => filename, :path => dest_path), :prefix => false

          # sudo "rm -f #{dest_path}"
          @vm.ssh.upload!(source_path, dest_path)
          sudo "chmod u+w #{dest_path}"
        end

        def source_paths_and_names
          # Examples:
          # DQ-DVD-2011-05
          # GEO-DVD-2011-Q2
          @paths_and_names ||= Dir['/Volumes/*-DVD-*/**/md*Ref.pdf'].map do |path|
            dir = File.dirname(path)
            name = path.match(/md(.*)Ref\.pdf/).captures.first
            [dir, name]
          end
        end
      end
    end

  end
end
