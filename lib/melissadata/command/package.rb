module MelissaData
  module Command

    class PackageCommand < Base
      register "package", "Package up the MelissaData databases"

      def execute
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
      end
    end

  end
end
