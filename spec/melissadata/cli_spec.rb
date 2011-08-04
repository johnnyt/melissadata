require "spec_helper"

module MelissaData
  describe CLI do

    before :each do
      @klass = MelissaData::CLI
    end

    context "registering" do
      it "registers a base command as a single invokable" do
        base = Class.new(MelissaData::Command::Base)
        name = "__test_registering_single_subcommand"
        @klass.register(base, name, name, "A description")
        @klass.tasks[name].should_not be_blank

        # assert @klass.tasks[name]
      end

      it "aliases methods if the alias option is given" do
        base = Class.new(MelissaData::Command::Base) do
          def execute
            raise "WORKED"
          end
        end

        name = "__test_registering_with_alias"
        @klass.register(base, name, name, "A description", :alias => "--ALIAS")
        lambda { @klass.start(["--ALIAS"]) }.should raise_error(RuntimeError)
      end
    end

  end
end
