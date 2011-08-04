module MelissaData
  module Command
    class CompileCommand < Base
      register "compile", "Compile the MelissaData shared objects"

      def self.source_root
        Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
      end

      def execute
        source_dir = Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
        raise Errors::DiscNotFound if source_dir.blank?

        dest_dir = "/tmp"

        possible_objects = %w[ address email name phone ]
        # objects = Dir.entries(source_dir).select{ |path| possible_objects.include?(path) }
        objects = %w[ email name ]

        objects.each do |obj|
          Dir["#{source_dir}/#{obj}/linux/gcc34_64bit/*.h"].each do |filename|
            copy_file filename, "/opt/melissadata/src/#{File.basename(filename)}"
          end

          filename = "#{source_dir}/#{obj}/linux/gcc34_64bit/libmd#{obj.capitalize}.so"
          copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"

          filename = "#{source_dir}/#{obj}/linux/interfaces/ruby/md#{obj.capitalize}RubyWrapper.cpp"
          copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"
        end

        template "Makefile", "/opt/melissadata/src/Makefile"
      end

    end
  end
end
