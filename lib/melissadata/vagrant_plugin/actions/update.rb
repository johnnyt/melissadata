module MelissaData::VagrantPlugin::Actions

  class Update < Base
    def call(env)
      @vm = env['vm']
      if @vm.created? && @vm.vm.running?
        target_root = env['config'].melissadata.target_path
        env.ui.info I18n.t("vagrant.plugins.melissadata.updating"), :prefix => false

        sudo "gem uninstall melissadata" if test? %Q!ruby -e 'require "rubygems"; require "melissadata"'! #"ruby -r md -e 'puts MD::VERSION'"
        gem_filename = "melissadata-#{MelissaData::VERSION}.gem"
        copy_file "#{File.expand_path("pkg/#{gem_filename}", MelissaData.gem_root)}"
        sudo "gem install #{target_root}/#{gem_filename} && rm #{target_root}/#{gem_filename}"

        # sudo "/etc/init.d/md_rpc_server start"
      else
        env.ui.error "Vagrant VM is not running", :prefix => false
      end

      @app.call(env)
    end
  end

end
