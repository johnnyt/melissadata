module MelissaData
  module VagrantPlugin
    class Command < ::Vagrant::Command::GroupBase
      register "md", "MelissaData stuff"
      # Examples:
      # DQ-DVD-2011-05
      # GEO-DVD-2011-Q2

      # source_root Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-.\d$/ }
      # def self.source_root
      #   @source_root ||= Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-.\d$/ }
      # end

      desc "install", "Install MelissaData gem on the vagrant box"
      def install
        target_vms.each { |vm| execute_on_vm(vm) }
      end

      protected

      def execute_on_vm(vm)
        # vm.env.actions.run(:melissadata, 'melissadata.source_root' => self.class.source_root)
        vm.env.actions.run(:melissadata, 'melissadata.source_path' => 'foo')
      end
    end
  end
end








  # module VagrantMelissaData
  #   class Command < Vagrant::Command::GroupBase
  #     register "md", "MelissaData stuff"
  #     source_root Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }

  #     # def self.source_root
  #     #   @source_root ||= Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
  #     # end

  #     # desc "add NAME URI", "Add a box to the system"
  #     # def add(name, uri)
  #     #   Box.add(env, name, uri)
  #     # end

  #     # desc "remove NAME", "Remove a box from the system"
  #     # def remove(name)
  #     #   b = env.boxes.find(name)
  #     #   raise Errors::BoxNotFound, :name => name if !b
  #     #   b.destroy
  #     # end

  #     # desc "repackage NAME", "Repackage an installed box into a `.box` file."
  #     # def repackage(name)
  #     #   b = env.boxes.find(name)
  #     #   raise Errors::BoxNotFound, :name => name if !b
  #     #   b.repackage
  #     # end

  #     desc "install", "Install MelissaData gem on the vagrant box"
  #     def install
  #       # source_dir = Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
  #       source_dir = self.class.source_root
  #       raise Errors::DiscNotFound if source_dir.blank?

  #       dest_dir = "/tmp"

  #       possible_objects = %w[ address email name phone ]
  #       # objects = Dir.entries(source_dir).select{ |path| possible_objects.include?(path) }
  #       objects = %w[ email name ]

  #       objects.each do |obj|
  #         # Dir["#{source_dir}/#{obj}/linux/gcc34_64bit/*.h"].each do |filename|
  #         #   copy_file filename, "/opt/melissadata/src/#{File.basename(filename)}"
  #         # end

  #         filename = "#{source_dir}/#{obj}/linux/gcc34_64bit/libmd#{obj.capitalize}.so"
  #         target_vms.each do |vm|
  #           vm.ssh.upload!(StringIO.new(filename), File.join(config.directory, 'lib', File.basename(filename)))
  #         end
  #         # copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"

  #         # filename = "#{source_dir}/#{obj}/linux/interfaces/ruby/md#{obj.capitalize}RubyWrapper.cpp"
  #         # copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"
  #       end

  #       # template "Makefile", "/opt/melissadata/src/Makefile"


  #       env.ui.info "Hi there", :prefix => false
  #       # boxes = env.boxes.sort
  #       # return env.ui.warn(I18n.t("vagrant.commands.box.no_installed_boxes"), :prefix => false) if boxes.empty?
  #       # boxes.each { |b| env.ui.info(b.name, :prefix => false) }
  #     end


  #   # class Command < Vagrant::Command::Base
  #   #   register "rake", "Run a rake task inside the VM environment"
  #   #   argument :rake_command, :type => :array, :required => false, :desc => "The command to run on the VM via Rake"
  #   #   class_option :cwd, :type => :string, :default => nil

  #   #   # Executes the given rake command on the VMs that are represented
  #   #   # by this environment.
  #   #   def execute
  #   #     command = (rake_command || []).join(" ")
  #   #     target_vms.each { |vm| execute_on_vm(vm, command) }
  #   #   end

  #   #   protected

  #   #   # Executes a command on a specific VM.
  #   #   def execute_on_vm(vm, command)
  #   #     vm.env.actions.run(:rake,
  #   #                        "rake.command" => command,
  #   #                        "rake.cwd" => options[:cwd])
  #   #   end
  #   # end

  #   end
  # end



  # # module VagrantMelissaData
  # #   class Command < Vagrant::Command::Base
  # #     register "md", "MelissaData stuff"
  # #     argument :rake_command, :type => :array, :required => false, :desc => "The command to run on the VM via MelissaData"
  # #     class_option :cwd, :type => :string, :default => nil

  # #     # Executes the given rake command on the VMs that are represented
  # #     # by this environment.
  # #     def execute
  # #       command = (rake_command || []).join(" ")
  # #       target_vms.each { |vm| execute_on_vm(vm, command) }
  # #     end

  # #     protected

  # #     # Executes a command on a specific VM.
  # #     def execute_on_vm(vm, command)
  # #       vm.env.actions.run(:rake,
  # #                          "rake.command" => command,
  # #                          "rake.cwd" => options[:cwd])
  # #     end
  # #   end
  # # end
