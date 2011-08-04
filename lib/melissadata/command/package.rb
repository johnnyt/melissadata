module MelissaData
  module Command
    class PackageCommand < Base
      # class_option :base, :type => :string, :default => nil
      # class_option :output, :type => :string, :default => nil
      # class_option :include, :type => :array, :default => nil
      # class_option :melissadatafile, :type => :string, :default => nil
      register "package", "Package up the MelissaData databases"

      def execute


    # desc "package", "Zips up data files from DVD and uploads them to remote servers"
    # # method_option :path, :type => :string, :default => '/usr/lib/ruby/1.8/x86_64-linux', :desc => "Path to MelissaData DVD"
    # method_option :username, :aliases => '-u', :type => :string, :required => true, :desc => "CloudFiles Username"
    # method_option :api_key, :aliases => '-a', :type => :string, :required => true, :desc => "CloudFiles API Key"
    # method_option :bucket_name, :aliases => '-b', :type => :string, :desc => "CloudFiles Bucket name"

    # def package
      source_dir = Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
      raise Errors::DiscNotFound if source_dir.blank?

    #   dest_dir = "/tmp"

    #   possible_objects = %w[ address email name phone ]
    #   # objects = Dir.entries(source_dir).select{ |path| possible_objects.include?(path) }
    #   objects = %w[ email name ]

    #   objects.each do |obj|
    #     data_file = "#{dest_dir}/#{obj}.tgz"
    #     inside "#{source_dir}/#{obj}" do
    #       run "tar czf #{data_file} data"
    #     end

    #     say_status :upload, "#{obj}.tgz to #{options[:bucket_name]}"
    #     cf = CloudFiles::Connection.new(:username => options[:username], :api_key => options[:api_key])
    #     cont = cf.container options[:bucket_name]
    #     remote_object = cont.create_object "#{obj}.tgz", false
    #     remote_object.load_from_filename data_file

    #     # "#{source_dir}/#{obj}/linux/gcc34_64bit/*.h" => /opt/melissadata/src/
    #     # "#{source_dir}/#{obj}/linux/gcc34_64bit/libmdEmail.so" => /opt/melissadata/lib/
    #     # "#{source_dir}/#{obj}/linux/interfaces/ruby/mdEmailRubyWrapper.cpp" => /opt/melissadata/lib/

    #     # inside "#{source_dir}/#{obj}/linux/gcc34_64bit" do
    #     #   run "tar czf #{data_file} data"
    #     # end
    #   end
    # end



        # return package_base if options[:base]
        # package_target
      end

      protected

      # def package_base
      #   vm = VM.find(options[:base], env)
      #   raise Errors::BaseVMNotFound, :name => options[:base] if !vm.created?
      #   package_vm(vm)
      # end

      # def package_target
      #   raise Errors::MultiVMTargetRequired, :command => "package" if target_vms.length > 1
      #   vm = target_vms.first
      #   raise Errors::VMNotCreatedError if !vm.created?
      #   package_vm(vm)
      # end

      # def package_vm(vm)
      #   opts = options.inject({}) do |acc, data|
      #     k,v = data
      #     acc["package.#{k}"] = v
      #     acc
      #   end

      #   vm.package(opts)
      # end
    end
  end
end
