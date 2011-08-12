module MelissaData
  module VagrantPlugin
    module Actions

      # A Vagrant middleware which copies files from MelissaData DVDs to the VM
      # and then compiles the shared objects
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

            sudo "mkdir -p #{%w[ src lib data ].map{ |sub| "#{target_root}/#{sub}" }.join(' ')}"
            sudo "chown -R vagrant:vagrant #{target_root}" #if test? "[ -e #{target_root} ]"

            license_path = '/opt/melissadata/license.txt'
            unless test? "[ -e #{license_path} ]"
              license = env.ui.ask "Enter your MelissaData license:"
              @vm.ssh.upload!(StringIO.new("#{license}\n"), license_path)
            end

            sudo "gem uninstall melissadata" if test? "ruby -r md -e 'puts MD::VERSION'"
            gem_filename = "melissadata-#{MelissaData::VERSION}.gem"
            copy_file "#{File.expand_path("pkg/#{gem_filename}", MelissaData.gem_root)}"
            sudo "gem install #{target_root}/#{gem_filename} && rm #{target_root}/#{gem_filename}"

            unless source_paths_and_names.empty?
              source_paths_and_names.each do |source_path,name|
                Dir["#{source_path}/linux/gcc34_64bit/*.h"].each{ |filename| copy_file filename, 'src' }
                copy_file "#{source_path}/linux/gcc34_64bit/libmd#{name}.so", 'lib'
                copy_file "#{source_path}/linux/interfaces/ruby/md#{name}RubyWrapper.cpp", 'src'
                Dir["#{source_path}/data/*"].each{ |filename| copy_file filename, 'data' }
              end

              env.ui.info I18n.t("vagrant.plugins.melissadata.compiling"), :prefix => false
              exec "cd #{target_root}/src && make #{source_paths_and_names.map{ |path,name| name }.join(' ')}"
            end

            sudo "chown -R vagrant:vagrant #{target_root}"
            sudo "/etc/init.d/md_rpc_server start"
          else
            env.ui.error "Vagrant VM is not running", :prefix => false
          end

          @app.call(env)
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

        def package_data
          # source_paths_and_names.each do |source_path,name|
          #   data_file = "#{dest_dir}/#{obj}.tgz"
          #   inside "#{source_dir}/#{obj}" do
          #     run "tar czf #{data_file} data"
          #   end

          #   say_status :upload, "#{obj}.tgz to #{options[:bucket_name]}"
          #   cf = CloudFiles::Connection.new(:username => options[:username], :api_key => options[:api_key])
          #   cont = cf.container options[:bucket_name]
          #   remote_object = cont.create_object "#{obj}.tgz", false
          #   remote_object.load_from_filename data_file
          # end
        end

      end
    end

  end
end
