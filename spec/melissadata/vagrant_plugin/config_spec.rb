require "spec_helper"

module MelissaData::VagrantPlugin

  describe Config do
    before :each do
      @config = Config.new
      @errors = Vagrant::Config::ErrorRecorder.new
    end

    it "is valid by default" do
      @config.validate(@errors)
      @errors.errors.should be_empty
    end
  end

end
