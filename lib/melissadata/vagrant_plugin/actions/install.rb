module MelissaData::VagrantPlugin::Actions

  # A Vagrant middleware which copies files from MelissaData DVDs to the VM
  # and then compiles the shared objects
  class Install < Base
    def call(env)
      @vm = env['vm']
      if @vm.created? && @vm.vm.running?
        target_root = env['config'].melissadata.target_path
        env.ui.info I18n.t("vagrant.plugins.melissadata.installing", :path => target_root), :prefix => false

        sudo "mkdir -p #{%w[ src lib data ].map{ |sub| "#{target_root}/#{sub}" }.join(' ')}"
        sudo "chown -R vagrant:vagrant #{target_root}"

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
            Dir["#{source_path}/linux/gcc34_64bit/*.h"].each do |filename|
              sudo "rm -f #{target_root}/src/#{File.basename(filename)}"
              copy_file filename, 'src'
            end
            sudo "rm -f #{target_root}/lib/libmd#{name}.so"
            copy_file "#{source_path}/linux/gcc34_64bit/libmd#{name}.so", 'lib'
            sudo "rm -f #{target_root}/src/md#{name}RubyWrapper.cpp"
            copy_file "#{source_path}/linux/interfaces/ruby/md#{name}RubyWrapper.cpp", 'src'

            Dir["#{source_path}/data/*"].each do |filename|
              sudo "rm -rf #{target_root}/data/#{File.basename(filename)}"
              copy_dir filename, 'data'
            end
          end

          env.ui.info I18n.t("vagrant.plugins.melissadata.compiling"), :prefix => false
          exec "cd #{target_root}/src && make #{source_paths_and_names.map{ |path,name| name }.join(' ')}"
        end

        sudo "chown -R vagrant:vagrant #{target_root}"
        sudo "/etc/init.d/md_tcp_server start"
        sudo "/etc/init.d/md_unix_server start"
      else
        env.ui.error "Vagrant VM is not running", :prefix => false
      end

      @app.call(env)
    end
  end

end
