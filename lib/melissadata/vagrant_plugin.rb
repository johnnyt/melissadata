$LOAD_PATH.unshift File.dirname(__FILE__)
require 'vagrant'
require File.expand_path('melissadata', File.dirname(__FILE__))
require 'vagrant_plugin/config'
require 'vagrant_plugin/command'
require 'vagrant_plugin/middleware'

# Create a new middleware stack "rake" which is executed for
# rake commands. See the VagrantRake::Middleware docs for more
# information.
melissadata = Vagrant::Action::Builder.new do
  use MelissaData::VagrantPlugin::Middleware
end

Vagrant::Action.register(:melissadata, melissadata)

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../../locales/en.yml", __FILE__)
