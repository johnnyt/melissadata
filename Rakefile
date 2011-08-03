bundler_installed = !!(%x[gem list] =~ /^bundler/) && File.exists?('Gemfile.lock')

desc "Setup the local environment"
task :setup do
  sh %Q!gem install bundler --no-ri --no-rdoc! unless bundler_installed
  output = `bundle check 2>&1`
  unless $?.to_i == 0
    # puts output
    sh "bundle install"
    # puts
  end

  # Dir['config/*.example'].each do |example_file|
  #   config_file = example_file.gsub(/\.example/,'')
  #   sh %Q!cp #{example_file} #{config_file}! unless File.exists?(config_file)
  # end

  puts "Done!\n\n"
end

if bundler_installed
  require 'bundler'
  Bundler::GemHelper.install_tasks

  require 'rspec/core/rake_task'

  task :default => [:spec]
  task :test => [:spec]

  desc "run spec tests"
  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end
