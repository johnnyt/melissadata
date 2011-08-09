require "spec_helper"

module MelissaData
  module VagrantPlugin

    describe Config do
      before :each do
        @config = VagrantPlugin::Config.new
        @errors = Vagrant::Config::ErrorRecorder.new
      end

      it "is valid by default" do
        @config.validate(@errors)
        @errors.errors.should be_empty
      end

      # it "is invalid if directory is not a string" do
      #   @config.directory = 24
      #   @config.validate(@errors)
      #   @errors.errors.should_not be_empty
      # end

    end

  end
end
