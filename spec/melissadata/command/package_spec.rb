require 'spec_helper'

module MelissaData
  module Command

    describe PackageCommand do

      describe "#default" do

        before(:each) do
          @command = PackageCommand.new
        end

        xit "requires a MelissaData disc image" do
          lambda {@command.execute}.should raise_error(MelissaData::Errors::DiscNotFound)
        end

      end
    end

  end
end
