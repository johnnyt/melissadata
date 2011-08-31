require "spec_helper"

module MelissaData::Client

  describe Vagrant do
    before :each do
      @client = Vagrant.new
    end

    it "returns the correct version" do
      @client.version.should == MelissaData::VERSION
    end
  end

end
