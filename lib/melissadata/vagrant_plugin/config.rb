module MelissaData
  module VagrantPlugin
    # A configuration class to configure defaults which are used for
    # the `vagrant-rake` plugin.
    class Config < ::Vagrant::Config::Base
      configures :melissadata
      attr_accessor :target_path
      attr_accessor :source_path

      def initialize
        @target_path = '/opt/melissadata'
      end

      def validate(errors)
        errors.add(I18n.t("vagrant.plugins.melissadata.config_directory")) if target_path && !target_path.is_a?(String)
      end
    end
  end
end
