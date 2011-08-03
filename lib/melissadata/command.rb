require 'melissa-data/melissa-data'
require 'thor'
require 'cloudfiles'

module MelissaData

  class Command < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../../templates', File.dirname(__FILE__))
    end

    desc "package", "Zips up data files from DVD and uploads them to remote servers"
    # method_option :path, :type => :string, :default => '/usr/lib/ruby/1.8/x86_64-linux', :desc => "Path to MelissaData DVD"
    method_option :username, :aliases => '-u', :type => :string, :required => true, :desc => "CloudFiles Username"
    method_option :api_key, :aliases => '-a', :type => :string, :required => true, :desc => "CloudFiles API Key"
    method_option :bucket_name, :aliases => '-b', :type => :string, :desc => "CloudFiles Bucket name"

    def package
      source_dir = Dir['/Volumes/*'].detect{ |path| path =~ /DVD-\d{4}-\d{2}$/ }
      raise "Can't find MelissaData DVD in /Volumes" if source_dir.blank?

      dest_dir = "/tmp"

      possible_objects = %w[ address email name phone ]
      # objects = Dir.entries(source_dir).select{ |path| possible_objects.include?(path) }
      objects = %w[ email name ]

      objects.each do |obj|
        data_file = "#{dest_dir}/#{obj}.tgz"
        inside "#{source_dir}/#{obj}" do
          run "tar czf #{data_file} data"
        end

        say_status :upload, "#{obj}.tgz to #{options[:bucket_name]}"
        cf = CloudFiles::Connection.new(:username => options[:username], :api_key => options[:api_key])
        cont = cf.container options[:bucket_name]
        remote_object = cont.create_object "#{obj}.tgz", false
        remote_object.load_from_filename data_file

        # "#{source_dir}/#{obj}/linux/gcc34_64bit/*.h" => /opt/melissadata/src/
        # "#{source_dir}/#{obj}/linux/gcc34_64bit/libmdEmail.so" => /opt/melissadata/lib/
        # "#{source_dir}/#{obj}/linux/interfaces/ruby/mdEmailRubyWrapper.cpp" => /opt/melissadata/lib/

        # inside "#{source_dir}/#{obj}/linux/gcc34_64bit" do
        #   run "tar czf #{data_file} data"
        # end
      end
    end


    # desc "install", "Install MelissaData config, data files"
    # method_option :license, :required => true, :type => :string, :aliases => "-l", :desc => "MelissaData license string"
    # method_option :install_path, :type => :string, :default => '/opt/melissa_data', :desc => "Path to install to"
    # method_option :ruby_dir, :type => :string, :default => '/usr/lib/ruby/1.8/x86_64-linux', :desc => "Path to ruby libs"

    # method_option :data_bucket_name, :type => :string, :default => 'MelissaData', :aliases => "-b", :desc => "CloudFiles bucket name"
    # method_option :data_username, :required => true, :type => :string, :aliases => "-u", :desc => "Rackspace username"
    # method_option :data_api_key, :required => true, :type => :string, :aliases => "-a", :desc => "Rackspace API key"

    # def install
    #   # options[:license] = ask("Enter your MelissaData license:", :blue) if options[:license].blank?
    #   # options[:data_username] = ask("Enter your Rackspace username:", :blue) if options[:data_username].blank?
    #   # options[:data_api_key] = ask("Enter your Rackspace API key:", :blue) if options[:data_api_key].blank?

    #   config_dir = '~/.melissa-data'
    #   empty_directory config_dir

    #   template "config.rb", "#{config_dir}/config.rb"
    # end
  end

end
