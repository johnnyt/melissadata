require "spec_helper"

module MelissaData::VagrantPlugin::Actions

  describe Install do
    before :each do
      @vagrantfile_path = File.expand_path('Vagrantfile', MelissaData.gem_root)
      @env = Vagrant::Environment.new(:cwd => @vagrantfile_path).load!
      @vm = @env.vms.values.first
    end

    it "creates the target directory on the VM" do
      @vm.env.actions.run(:md_install)
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
  end

end
