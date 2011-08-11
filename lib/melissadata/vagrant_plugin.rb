$LOAD_PATH.unshift File.dirname(__FILE__)
require 'vagrant'

module MelissaData
  module VagrantPlugin
    module_function

    autoload :Config,     'vagrant_plugin/config'
    autoload :Command,    'vagrant_plugin/command'
    autoload :Actions,    'vagrant_plugin/actions'

    def load!
      Config; Command; Actions # due to autoload
      Vagrant::Action.register(:md_install, Vagrant::Action::Builder.new do
        use Actions::Install
      end)
    end
  end
end
