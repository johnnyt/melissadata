module MelissaData
  module VagrantPlugin
    # A Vagrant middleware which executes a rake task on a given
    # VM. This task will run "rake" on the VM that this action sequence
    # was run on. If an env variable "rake.command" is populated, then
    # this command will be executed by rake.
    class Middleware
      def initialize(app, env)
        @app = app
        @env = env
      end

      def call(env)
        if env["vm"].created? && env["vm"].vm.running?
          source_dir = env['melissadata.source_root']
          # raise MelissaData::Errors::DiscNotFound unless source_dir

          dest_dir = env['config'].melissadata.target_path

          env["vm"].ssh.execute do |ssh|
            # env.ui.info I18n.t("vagrant.plugins.melissadata.installing", :path => working_directory), :prefix => false

            ssh.exec!("sudo mkdir -p #{dest_dir}/lib && sudo chown -R vagrant:vagrant #{dest_dir}") do |channel, type, data|
              # Print the data directly to STDOUT, not doing any newlines
              # or any extra formatting of our own
              $stdout.print(data) if type != :exit_status
            end

            # Puts out an ending newline just to make sure we end on a new
            # line.
            $stdout.puts
          end

          # objects.each do |name, dir|
          #   # Dir["#{source_dir}/#{obj}/linux/gcc34_64bit/*.h"].each do |filename|
          #   #   copy_file filename, "/opt/melissadata/src/#{File.basename(filename)}"
          #   # end

          #   filename = "#{source_dir}/#{obj}/linux/gcc34_64bit/libmd#{obj.capitalize}.so"
          #   env['vm'].ssh.upload!(StringIO.new(filename), File.join(env['config'].melissadata.directory, 'lib', File.basename(filename)))
          #   # copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"

          #   # filename = "#{source_dir}/#{obj}/linux/interfaces/ruby/md#{obj.capitalize}RubyWrapper.cpp"
          #   # copy_file filename, "/opt/melissadata/lib/#{File.basename(filename)}"
          # end


          # template "Makefile", "/opt/melissadata/src/Makefile"


          # boxes = env.boxes.sort
          # return env.ui.warn(I18n.t("vagrant.commands.box.no_installed_boxes"), :prefix => false) if boxes.empty?
          # boxes.each { |b| env.ui.info(b.name, :prefix => false) }

          # command = "rake #{env["rake.command"]}".strip

          # env["vm"].ssh.execute do |ssh|
          #   env.ui.info I18n.t("vagrant.plugins.melissadata.installing", :path => working_directory)

          #   ssh.exec!("cd #{working_directory}; #{command}") do |channel, type, data|
          #     # Print the data directly to STDOUT, not doing any newlines
          #     # or any extra formatting of our own
          #     $stdout.print(data) if type != :exit_status
          #   end

          #   # Puts out an ending newline just to make sure we end on a new
          #   # line.
          #   $stdout.puts
          # end
        else
          env.ui.error "Vagrant VM is not running", :prefix => false
        end

        @app.call(env)
      end

      protected

      def objects
        possible_objects = %w[ address email name phone ]
        objects = Dir.entries(source_dir).select{ |path| possible_objects.include?(path) }
        # objects = %w[ email name ]
      end

      def working_directory
        @env["rake.cwd"] || @env["config"].melissadata.target_path || @env["config"].vm.shared_folders["v-root"][:guestpath]
      end
    end
  end
end
