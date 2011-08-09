require "spec_helper"

module MelissaData
  module VagrantPlugin

    describe Command do
      before :each do
        @command = VagrantPlugin::Command
        @vagrantfile_path = File.expand_path('../../../../Vagrantfile', __FILE__)
        @env = Vagrant::Environment.new(:cwd => @vagrantfile_path).load!
        @vm = @env.vms.values.first
      end

      it "creates the target directory on the VM" do
        @vm.env.actions.run(:melissadata)
        @vm.exit_status('test -e /opt/melissadata').should == 0
      end


      xit "executes the command on every VM" do
        @vm.env.actions.should_receive(:run).with do |action, options|
          action.should == :melissadata
          # assert_equal "db:migrate", options["rake.command"]
          true
        end

        @env.cli("md", "install")
      end

      context "Single Object DVD" do
        before :each do
          path = File.expand_path('../../support/single_object_dvd', __FILE__)
          @vm.env.config.melissadata.source_path = path
        end

        xit "foo" do
          'foo'.should == 'bar'
        end
      end


      # should "execute fine with no command given" do
      #   @vm.env.actions.expects(:run).with() do |action, options|
      #     assert_equal :rake, action
      #     assert_equal "", options["rake.command"]
      #     true
      #   end

      #   @env.cli("rake")
      # end

      # should "execute within the nil cwd by default" do
      #   @vm.env.actions.expects(:run).with() do |action, options|
      #     assert_equal :rake, action
      #     assert_equal nil, options["rake.cwd"]
      #     true
      #   end

      #   @env.cli("rake")
      # end

      # should "execute within the given cwd" do
      #   @vm.env.actions.expects(:run).with() do |action, options|
      #     assert_equal :rake, action
      #     assert_equal "/foo/bar", options["rake.cwd"]
      #     true
      #   end

      #   @env.cli("rake", "--cwd", "/foo/bar")
      # end

    end

  end
end
