require 'melissa-data/melissa-data'
require 'thor'

module MelissaData

  class Command < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../../templates', File.dirname(__FILE__))
    end

    desc "install", "Install MelissaData config, data files"
    method_option :license, :required => true, :type => :string, :aliases => "-l", :desc => "MelissaData license string"
    method_option :install_path, :type => :string, :default => '/opt/melissa_data', :desc => "Path to install to"
    method_option :ruby_dir, :type => :string, :default => '/usr/lib/ruby/1.8/x86_64-linux', :desc => "Path to ruby libs"

    method_option :data_bucket_name, :type => :string, :default => 'MelissaData', :aliases => "-b", :desc => "CloudFiles bucket name"
    method_option :data_username, :required => true, :type => :string, :aliases => "-u", :desc => "Rackspace username"
    method_option :data_api_key, :required => true, :type => :string, :aliases => "-a", :desc => "Rackspace API key"

    def install
      # options[:license] = ask("Enter your MelissaData license:", :blue) if options[:license].blank?
      # options[:data_username] = ask("Enter your Rackspace username:", :blue) if options[:data_username].blank?
      # options[:data_api_key] = ask("Enter your Rackspace API key:", :blue) if options[:data_api_key].blank?

      config_dir = '~/.melissa-data'
      empty_directory config_dir

      template "config.rb", "#{config_dir}/config.rb"
    end
  end

end
