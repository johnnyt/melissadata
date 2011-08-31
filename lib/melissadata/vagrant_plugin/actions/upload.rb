module MelissaData::VagrantPlugin::Actions

  class Upload < Base
    def call(env)
      @vm = env['vm']
      if @vm.created? && @vm.vm.running?
        target_root = env['config'].melissadata.target_path
        env.ui.info I18n.t("vagrant.plugins.melissadata.updating"), :prefix => false


        #   objects.each do |obj|
        #     data_file = "#{dest_dir}/#{obj}.tgz"
        #     inside "#{source_dir}/#{obj}" do
        #       run "tar czf #{data_file} data"
        #     end

        #     say_status :upload, "#{obj}.tgz to #{options[:bucket_name]}"
        #     cf = CloudFiles::Connection.new(:username => options[:username], :api_key => options[:api_key])
        #     cont = cf.container options[:bucket_name]
        #     remote_object = cont.create_object "#{obj}.tgz", false
        #     remote_object.load_from_filename data_file

        #     # "#{source_dir}/#{obj}/linux/gcc34_64bit/*.h" => /opt/melissadata/src/
        #     # "#{source_dir}/#{obj}/linux/gcc34_64bit/libmdEmail.so" => /opt/melissadata/lib/
        #     # "#{source_dir}/#{obj}/linux/interfaces/ruby/mdEmailRubyWrapper.cpp" => /opt/melissadata/lib/

        #     # inside "#{source_dir}/#{obj}/linux/gcc34_64bit" do
        #     #   run "tar czf #{data_file} data"
        #     # end
        #   end


        sudo "gem uninstall melissadata" if test? "ruby -r md -e 'puts MD::VERSION'" #%Q!ruby -e 'require "rubygems"; require "melissadata"'!
        gem_filename = "melissadata-#{MelissaData::VERSION}.gem"
        copy_file "#{File.expand_path("pkg/#{gem_filename}", MelissaData.gem_root)}"
        sudo "gem install #{target_root}/#{gem_filename} && rm #{target_root}/#{gem_filename}"
      else
        env.ui.error "Vagrant VM is not running", :prefix => false
      end

      @app.call(env)
    end
  end

end
