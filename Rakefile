bundler_installed = !!(%x[gem list] =~ /^bundler/) && File.exists?('Gemfile.lock')

desc "Setup the local environment"
task :setup do
  sh %Q!gem install bundler --no-ri --no-rdoc! unless bundler_installed
  output = `bundle check 2>&1`
  unless $?.to_i == 0
    sh "bundle install"
  end

  unless %x[bundle exec vagrant box list] =~ /lucid64$/
    sh "bundle exec vagrant box add lucid64 http://files.vagrantup.com/lucid64.box"
  end

  sh "bundle exec vagrant up"

  puts <<-STR


    Now make sure you have a MelissaData DVD (or .dmg) mounted (e.g. IPL-DVD-2011-Q1),
    then run:

      bundle exec vagrant md install

  STR
end

if bundler_installed
  desc "Install MelissaData onto the Vagrant VM"
  task :install_md do
    sh "bundle exec vagrant md install"
  end

  require 'bundler'
  Bundler::GemHelper.install_tasks

  require 'rspec/core/rake_task'

  task :default => [:spec]
  task :test => [:spec]

  desc "Run specs"
  RSpec::Core::RakeTask.new('spec') do |t|
    t.rspec_opts = ['--backtrace', '--format', 'documentation']
    t.pattern = 'spec/**/*_spec.rb'
  end

  if RUBY_VERSION !~ /^1\.9/
    namespace :spec do
      desc "Run specs with RCov"
      RSpec::Core::RakeTask.new('rcov') do |t|
        t.pattern = 'spec/**/*_spec.rb'
        t.rspec_opts = ['--backtrace', '--format', 'documentation']
        t.rcov = true
        # t.rcov_opts = ['--exclude', 'some/path']
      end
    end
  end
end
